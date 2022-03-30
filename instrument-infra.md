### Instrument the Infrastructure Agent

The goal here was to add the infra agent to a Sourcegraph Docker-compose instance that was running locally in Docker Desktop. 
I did this because I wanted container metrics.


#### Pre-req

I already had a local docker-compose Sourcegraph instance I had ran prior to this.

#### Install the Infrastructure Agent

This was very easy to do with my existing New Relic account. I was already logged in, and clicked the [link from the doc for "Guided install"](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/get-started/install-infrastructure-agent/#quick)
It automagically directed me to my account and I ran through the steps.

The install worked almost _too well_ because upon seeing my data, I realized the install was to my host machine - my mac was gathering metrics from anything
my laptop was doing. In retrospect that makes perfect sense because the host was my machine. No offense New Relic, but I was hoping to only monitor Sourcegraph :)

#### Figure out how adjust the install for just the docker-compose instance

The Infra agent is installed in the `etc` directory on the host machine. On a mac, navigate to the root directory and typing `cd /etc/` like ` ~ cd /etc/`

The trouble was, the files in that directory are read only. [And the docs say... ](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/configure-infrastructure-agent/)
> to configure the infrastructure agent, use the newrelic-infra.yml file. Its default location is:
> Linux: /etc/newrelic-infra.yml

I tried for the life of my to find a way to edit the newrelic-infra.yml there:

* Tried various random tips on the internets and stackoverflow
* Tried using nano / vi / vim / anything, but I couldn't open the file in the terminal
* Tried installing nano / vi / vim / anything because maybe that was the problem
* Tried navigating to the directory in terminal and using `code .` to open the director in VSC. That worked, but I could not save edits to the files. Nor could I add files to the directory.

Ultimately I realized this effort was futile because even if I did edit the file there, how would it monitor just the Sourecgraph instance the way I wanted it to?


#### Look for alternative methods

I re-thought my approach and looked again at the [Infra Docker compose docs](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/docker-container-infrastructure-monitoring/#docker-compose)

I came across a doc that suggested run the Infrastructure agent as its own service. That made sense to me! Since Sourecgraph is a bunch of services, maybe I could do that instead?
I settled on the [Custom Docker Compose](https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/docker-container-infrastructure-monitoring/#docker-compose)
set up. But to be honest, I may have tried the CLI version too - it's kind of a blur now. 

https://hub.docker.com/r/newrelic/infrastructure/

Navigate to the docker-compose folder

<img width="744" alt="image" src="https://user-images.githubusercontent.com/27694443/160729508-2d0e139a-4fce-4c67-ac45-580e8a58dbeb.png">


Add the New Relic stuff to the top of the Docker-compose file like so:

```
➜  docker-compose git:(release) ✗ cat docker-compose.yaml 
version: '2.4'
services:
  # Description: This container will migrate the Postgres `frontend`,
  # `codeintel`, and `codeinsights` databases
  #
  # Disk: None
  # Ports: None
  #
  # This container should start after the database instance starts, perform the migrations
  # and then exit cleanly. After exiting the `frontend` service is allowed to start.
  #
  # If you're using a DB instance hosted outside of docker-compose, the environment variables
  # for this container will need to be updated to reflect the new connection information.


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

TBD!

