### Sourcegraph to New Relic Observability Adventure time!


The short story is that, Sourcegraph is a really amazing tool because it allows you to easily navigate your code hosts! Sourcegraph deployments are comprised of several services that are deployed with one of our supported methods: Docker, Docker-compose or Kubernetes.
Under the hood, the code is mostly Go and Typescript.

Sourcegraph comes pre-built with Grafana dashboards that are powered by Prometheus metrics and the alerts are built right into the code. This works well, but sometimes we have customers ask, how can they see Sourcegraphs metrics in their own observability platform? And would it make troubleshooting and observing instance health easier? With what I know about New Relic, I think so!! Thus, I created this to chronical that journey along with that I learned along the way.


### Observability goals for New Relic:

* [Set up Sourcegraph dev environment](develop-sourcegraph.md)
* [Instrument the Infrastructure agent to see container metrics for all Sourcegraphs services, i.e. Gitserver, Frontend, Repo-updater, etc](instrument-infra.md)
* View container logs
* See external service dependencies like Github and Gitlab
* Create cool Dashboards that perform a similar function to those within Sourcegraph's built in Grafana
* Instrument the Go agent and see important transactions
* Add alerting
* Instrument the Browser agent
* Monitor the psql databases
* ... more tbd?!


### Pre-reqs / tools I used

* New Relic account
* Macbook Pro
* Docker-desktop
* Sourcegraph docker-compose deployment
* Visual Studio Code
* [Docker in Visual Studio Code Extension](https://code.visualstudio.com/docs/containers/overview)
