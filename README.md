### Sourcegraph to New Relic Observability Adventure time!


The short story is that, Sourcegraph is a really amazing tool because it allows you to easily navigate your code hosts! Sourcegraph deployments are comprised of several services that are deployed with one of our supported methods: Docker, Docker-compose or Kubernetes.
Under the hood, the code is mostly Go and Typescript.

Sourcegraph comes pre-built with Grafana dashboards that are powered by Prometheus metrics and the alerts are built right into the code. This works well, but sometimes we have customers ask, how can they see Sourcegraphs metrics in their own observability platform? And would it make troubleshooting and observing instance health easier? With what I know about New Relic, I think so!! Thus, I created this to chronical that journey along with that I learned along the way.


### Observability goals for New Relic:

* [Set up Sourcegraph dev environment](develop-sourcegraph.md)
* [Instrument the Infrastructure agent locally](instrument-infra-locally.md)
* [Instrument the Infrastructure agent on GCP](instrument-infra-agent-gcp.md)
* Create cool Dashboards
* Add alerting

### Stretch goals...
* Instrument the Browser agent
* Monitor the psql databases
* Instrument the Go agent and see important transactions
* See external service dependencies like Github and Gitlab
* View container logs
* ... more tbd?!


### Pre-reqs / tools I used

* New Relic account
* Macbook Pro
* Docker-desktop
* Sourcegraph docker-compose deployment
* Visual Studio Code
* [Docker in Visual Studio Code Extension](https://code.visualstudio.com/docs/containers/overview)

### Summary

* GCP Ubuntu VM hosting Sourcegraph Docker-compose instance
  * Connect forked Github repo to GCP VM and clone repo
  *  Infrastructure Agent
  *  Infrastrucure Log forwarding
  *  New Relic + GCP integration
  *  GCP Logs forwarded to New Relic
  *  Attempted Redis and Postgres OHI
  *  Golden Alerts
*  Docker Desktop run applications and c
  *  Brawl cards - Python Agent
    *  Python Flask web app 
    *  Python script generating fake traffic
  *  Cards - Infra + Python Agent
    *  Python Flask web app w/ Docker and Postgres DB example
    *  Python script generating fake traffic
  *  Synthetics private minion
    * Was attempting to run Synthetics checks on local host  
  *  Infrastructure Agent run as container
    * Sourcegraph dev build. Added new container and build.sh
    * Sourcegraph docker-compose. Added it to docker-compose.yml to run at startup  
* Synthetics check
  * Endpoint availabiity scripted API for Nerdgraph API https://api.newrelic.com/graphql
  * 
  *  
