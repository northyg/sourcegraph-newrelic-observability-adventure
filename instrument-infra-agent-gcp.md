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

Example for Github: 
* https://cloud.google.com/build/docs/automating-builds/build-repos-from-github

Update: The Sourecgraph GCP build script failed and decided to press to other matters for now.


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


