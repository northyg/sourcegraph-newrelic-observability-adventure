WIP / notepad


### Picking a VM!

Create a GCP Linux VM that fits the [Infrastructure Agent linux requirements.](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/install-infrastructure-monitoring-agent-linux/)

Since my goal was to run Sourcegraph Docker-Compose on it, I cross referenced the Infra docs for compatability and chose what was suggested

* https://docs.sourcegraph.com/admin/install/docker-compose/google_cloud

* Under the “Boot Disk” options, select the following:
* Operating System: Ubuntu
* Version: Ubuntu 18.04 LTS
* Boot disk type: SSD persistent disk
* Check the boxes for Allow HTTP traffic and Allow HTTPS traffic in the Firewall section

Sourcegraph / repo linking Note: 

In order to link your repo with your code host provider, you'll need to do some extra steps. The Sourcegraph build script from their docs, will not work unless you do this first.

Examples: 
* https://cloud.google.com/build/docs/automating-builds/build-repos-from-github
* https://cloud.google.com/source-repositories/docs/cloning-repositories

Update: The Sourecgraph GCP build script failed. I think its because I forgot to add a disk for docker.

Adding disk for docker... reset instance. Maybe there is easier way to restart the start up script ?

`sudo lsblk` check which volumes are mounted

# Follow the status of the user data script you provided earlier
`tail -c +0 -f /var/log/syslog | grep startup-script`

# (Once the user data script completes) monitor the health of the "sourcegraph-frontend" container
`docker ps --filter="name=sourcegraph-frontend-0"`

* https://cloud.google.com/compute/docs/disks/add-persistent-disk#console


### Authenticating to Google Cloud SDK

* https://cloud.google.com/sdk/gcloud/reference/auth

`gcloud auth login`

I preferred to connect to the VM in my mac terminal with the following. This is only one way though:

Find the project ID, zone and vm_name on this page first:

https://console.cloud.google.com/compute/instances?cloudshell=false&project=

Then you can fill this out:

`gcloud compute ssh --project=PROJECT_ID --zone=ZONE VM_NAME`

* https://cloud.google.com/compute/docs/instances/connecting-to-instance#gcloud


### Installing the Infrastructure Agent 

This was by far the easiest part!! I followed the doc steps first run but turns out the Guided install in the Product is way easier.

* [Also relevent, automatic install for GCP, doc here.](https://docs.newrelic.com/docs/infrastructure/google-cloud-platform-integrations/get-started/introduction-google-cloud-platform-integrations/)

#### Option A) Install from the docs page

* https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/install-infrastructure-monitoring-agent-linux/

I followed the steps for Ubuntu Linux, installing the agent as Root user

This took more time and should have done guided install!

#### Option B) Guided in product install

Do this!! Go to New Relic > Add more Data > Guided Install 

<img width="302" alt="image" src="https://user-images.githubusercontent.com/27694443/163319886-30047811-862a-4f26-ae7a-e8779a3a9f8e.png">

<img width="1105" alt="image" src="https://user-images.githubusercontent.com/27694443/163320106-8cebd99a-0d2e-44bb-9192-5bf211e5d6f0.png">

Then follow the prompts, copy / paste the Curl command into your GCP authed terminal like below:


<img width="590" alt="image" src="https://user-images.githubusercontent.com/27694443/163319473-c03bd6bb-05ce-49c5-8f4e-c722f899377d.png">

Follow the link to your New Relic instance... and Voila!! Metrics and Logs in a few clicks!


The Installer even asked if I wanted to add Golden Signals alerts automagically:

*  https://newrelic.com/instant-observability/golden-signals-for-web-servers/aae62e98-51c4-4e73-82b4-29d9ae95433a

Pretty cool! 

#### Modifying the newrelic-infra.yml and finding the newrelic-infra  directory

* Navigate to the directory `$ cd /etc/` 
* You should see them in the list `ls` 

`newrelic-infra` has some extra files `integrations.d` and   `logging.d`. Will go over those later.

#### Add custom attributes to the `newrelic-infra.yml`

* [Infra custom attribute doc](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/infrastructure-agent-configuration-settings/#custom-attributes)

Open the infra file in nano or vim. Add sudo so you can write changes and not just read.

`sudo vim newrelic-infra.yml`

Decide what you want to custom attributes you want to add! For now I will add some custom names:

```
custom_attributes:
  environment: nr-demo
  service: data nerd service
  team: data-nerd
```

And optionally you can change the reported host name:

`display_name: teslaOne`

[Restart infra agent docs](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/manage-your-agent/start-stop-restart-infrastructure-agent/)

`sudo systemctl restart newrelic-infra`

In the New Relic Host UI you should see the changes in the Activity Stream:

![image](https://user-images.githubusercontent.com/27694443/163326114-54c74f88-0427-4d1d-8bed-3df24605cb4e.png)


#### Fixing Sourcegraph install

Long story short I forgot to add a docker volume. The start up script failed. I added the volume... how to get to root user where sourcegraph repo lives:

```
giselle@instance-1:~$ sudo -i
root@instance-1:~# ls
deploy-sourcegraph-docker
```
Script fails because directory is not empty. Trying again and tail logs.

`rm -r deploy-sourcegraph-docker/`

Seems I should have paid closer attention to number of CPUs when making the VM 😆

```
Apr 14 07:22:40 instance-1 GCEMetadataScripts[2396]: 2022/04/14 07:22:40 GCEMetadataScripts: startup-script: ERROR: for zoekt-indexserver-0  Cannot create container for service zoekt-indexserver-0: Range of CPUs is from 0.01 to 4.00, as there are only 4 CPUs available|
```
Interesting!! The my forked sourcegraph version had an infra set up in it and it seems to override the other infra file?
The host is now what I had set up before and the change is seen in Infra logs:

![image](https://user-images.githubusercontent.com/27694443/163336203-65ef15a9-c93e-4c5e-bd12-8820a47a3923.png)



