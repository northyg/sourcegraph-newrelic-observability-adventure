### Postgres integration steps

I followed the steps here.

https://docs.newrelic.com/docs/infrastructure/host-integrations/host-integrations-list/postgresql/postgresql-integration/

Automatically Infra postgres install failed. It did not like the port I gave it even though running `docker ps` I got the port as 5462...

```
  New Relic installation complete 

  --------------------
  Installation Summary

  ✔  Infrastructure Agent  (installed)  
  ✔  Logs Integration  (installed)  
  !  PostgreSQL Integration  (incomplete)  
  !  Redis Integration  (incomplete)  

  Installation was successful overall, however, one or more installations could not be completed.
  Follow the instructions at the URL below to complete the installation process. 

  ⮕  https://onenr.io/0dQeVb1kowe

  View your logs at the link below:
  ⮕  https://onenr.io/0VRVAX5yWwa
```

Attempted manual install

* I also tried the steps here. Not sure if that matters? https://cloud.google.com/sql/docs/postgres/connect-admin-ip#local

To access the database in Sourcegraph run:

` sudo -i` or `sudo su`
`docker exec -it pgsql psql -U sg`

Run the steps from the aforementationed doc to create user in db

Will manually add the config file to this directory

```
/etc/newrelic-infra/integrations.d$ ls
docker-config.yml  redis-config.yml  redis-config.yml.sample
```

Auto install might have failed because I didnt have go installed
`go version` 
If no go, https://cloud.google.com/go/docs/setup
Install go

```
Command 'go' not found, but can be installed with:

snap install go         # version 1.18, or
apt  install golang-go
apt  install gccgo-go 
```

Clone the repo 
https://github.com/newrelic/nri-postgresql

`go mod tidy`

See paths and things
`gopls -rpc.trace -v check path/to/file.go`

WIP / Not working getting compile errors when running `make`
