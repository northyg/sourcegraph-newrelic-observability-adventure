### Sourcegraph to New Relic Observability Adventure time!


The short story is that, Sourcegraph is a really amazing tool because it allows you to easily navigate your code hosts! Sourcegraph deployments are comprised of several services that are deployed with one of our supported methods: Docker, Docker-compose or Kubernetes.
Under the hood, the code is mostly Go and Typescript.

Sourcegraph comes pre-built with Grafana dashboards that are powered by Prometheus metrics and the alerts are built right into the code. This works well, but sometimes we have customers ask, how can they see Sourcegraphs metrics in their own observability platform? And would it make troubleshooting and observing instance health easier? With what I know about New Relic, I think so!! Thus, I created this to chronical that journey along with that I learned along the way.


### Observability goals for New Relic:

* [Set up Sourcegraph dev environment](develop-sourcegraph.md)
* [Instrument the Infrastructure agent locally](instrument-infra-locally.md)
* [Instrument the Infrastructure agent on GCP](instrument-infra-gcp.md)
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
