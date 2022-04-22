#!/usr/bin/env bash

set -ex
cd "$(dirname "${BASH_SOURCE[0]}")"

# from


INFRASTRUCTURE_RELEASE="latest"
docker pull newrelic/infrastructure:"$INFRASTRUCTURE_RELEASE"


# build
docker build -t "${IMAGE:-sourcegraph/nr-sg}" .

#run 
docker run \
    -d \
    --name nr-sg \
    --network=host \
    --cap-add=SYS_PTRACE \
    --privileged \
    --pid=host \
    -v "/:/host:ro" \
    -v "/var/run/docker.sock:/var/run/docker.sock" \
    "${IMAGE:-sourcegraph/nr-sg}"

