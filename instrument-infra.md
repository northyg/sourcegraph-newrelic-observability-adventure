### Instrument the Infrastructure Agent with Sourcegraph Docker-Compose deployment

Goal was to add the Infrastrcture agent to a Sourcegraph Docker-compose instance that was running locally in Docker Desktop. Perhaps not the best way, but this is one way that worked for me!

#### Pre-req / things I used

* [Sourcegraph docker-compose github](https://github.com/sourcegraph/deploy-sourcegraph-docker/) - be sure to clone a specific version, recommend the last version, and not main. 
* [Sourcegraph Docker compose Install docs](https://docs.sourcegraph.com/admin/install/docker-compose)
* Mac + terminal (note Sourcegraph doesn't run on Windows)
* [New Relic Infrastructure yaml](https://github.com/newrelic/infrastructure-agent/blob/master/assets/examples/infrastructure/newrelic-infra-template.yml.example)
* Visual studio code with Docker Extension
* Docker Desktop

#### Install the Infrastructure Agent with Docker Compose

In this method, the agent is [installed as it's own container.](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/docker-container-infrastructure-monitoring/#docker-compose) I came up with a variation on the install docs which I will go over below:


A. From within your Sourcegraph Docker-compose install, navigate to the docker-compose folder:

<img width="744" alt="image" src="https://user-images.githubusercontent.com/27694443/160729508-2d0e139a-4fce-4c67-ac45-580e8a58dbeb.png">

B. You will be adding 2 files: `newrelic-infra.dockerfile` and `newrelic-infra.yml`

<img width="652" alt="image" src="https://user-images.githubusercontent.com/27694443/162897607-47d5d22f-90ad-40d2-ae1d-040ca5e3ac56.png">

C. In the `newrelic-infra.dockerfile` put:

```
FROM newrelic/infrastructure:latest
ADD newrelic-infra.yml /etc/newrelic-infra.yml
```
D. In the `newrelic-infra.yml` copy the contents or download a copy from [New Relic Infrastructure yaml](https://github.com/newrelic/infrastructure-agent/blob/master/assets/examples/infrastructure/newrelic-infra-template.yml.example)

Only the `license_key:` field is required. I suggested setting a few more fields. The value is your choice:

```
display_name: Sourcegraph

custom_attributes:
 environment: production
 service: Sourcegraph
 team: your-cool-team
```

E. Modify the existing Sourcegrpah Docker-compose file like to add the New Relic Infrastructure agent towards the top below `services:`. You can name the `container_name:` to something other than `newrelic-infra` if you'd like.

```
➜  docker-compose git:(release) ✗ cat docker-compose.yaml 
version: '2.4'
services:
....

  agent:
    container_name: newrelic-infra
    build:
      context: .
      dockerfile: newrelic-infra.dockerfile
    cap_add:
      - SYS_PTRACE
    network_mode: host
    pid: host
    privileged: true
    volumes:
      - "/:/host:ro"
      - "/var/run/docker.sock:/var/run/docker.sock"
    restart: unless-stopped

  ```
Then at the bottom where it says `volumes` add `agent:` to the list.

  ```
volumes:
  agent:
  caddy:
  gitserver-0:
  ```
F. Run `docker-compose build` in the `docker-compose` directory. This will build the infra agent and include it when running Sourcegraph.

<img width="838" alt="image" src="https://user-images.githubusercontent.com/27694443/162902087-b1905114-a49f-4f0b-90a1-5e01442811c7.png">

G. Run Sourcegraph in the same directory with `docker-compose up -d` or exclude the `d` if you'd like to see the services output which is good for seeing if something looks off.

H. Check Docker Desktop to see if your containers are running or run `docker ps` in the terminal.

I. Finally, check for your data in New Relic! Navigate to Infrastructure -> Hosts and you should see Sourcegraph! Within the processes, you should see familiar service names like `gitserver` and `frontend`!

<img width="1090" alt="image" src="https://user-images.githubusercontent.com/27694443/162903476-d64b4b54-544f-4ea2-a8f7-8fb46eae4833.png">

<img width="530" alt="image" src="https://user-images.githubusercontent.com/27694443/162903949-d3a3f8cb-18bc-4eb4-b043-39c4e2a6e4f2.png">


#### Summary



Pro: Was relatively easy to install!

Con: The agent can see the other Sourvegraph services but cannot see specifics inside of them like CPU usage, utilization, etc. Instead it reports on them as processes. For instance, all of Sourcegraph's services like Grafana, Jaeger, Gitserver, etc show up in the list. But when going to the Host > Containers > the metrics come in as 0%'s. This seems to be a limitation of running the agent as a container?


