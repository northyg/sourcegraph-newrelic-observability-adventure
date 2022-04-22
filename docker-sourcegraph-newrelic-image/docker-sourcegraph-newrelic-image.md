Example of how to add New Relic Infrastructure Docker image to Sourcegraph dev build / OSS

This is assuming you alreadh have the SG dev environment set up and good to go! :)
* https://docs.sourcegraph.com/dev

* Navigate to `sourcegraph/docker-images`
* I used the README.md in that directory as a reference to add more docker images
* Add a new directory with whatever name you want. I added `nr-sg`
* Within that directory, add a new Dockerfile, newrelic-infra.yml, and build.sh

* I was not able to "3. Add an image to the automated builds pipeline by adding it to...." part, however I could still spin up the docker image.
