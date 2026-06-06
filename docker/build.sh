#!/bin/bash
#Podman-compatible docker-based wrapper
set -xueo pipefail
pushd $(dirname $(realpath "$BASH_SOURCE"))
docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)"  -t oe-builder-yocto .
env PODMAN_USERNS=keep-id docker run --init --network=private --sig-proxy --rm -ti --pids-limit=-1 --shm-size=3g \
        --env PRSERV_HOST=localhost:0 --env CACHE=/sandbox-cache --env SSTATE_DIR=/sandbox-sstate \
        --env DL_DIR=/sandbox/cache \
        --env SSTATE_DIR=/sandbox/sstate-cache \
        --env BB_ENV_PASSTHROUGH_ALLOWED="DL_DIR SSTATE_DIR PRSERV_HOST CACHE" \
	-v $(realpath $PWD/..):/sandbox:rw \
	-v $(realpath $PWD/..)/cache:/sandbox-cache:rw \
	-v $(realpath $PWD/..)/sstate-cache:/sandbox-sstate:rw \
	-w /sandbox oe-builder-yocto bash -lc "\
set -xeo pipefail; \
pwd; \
cd poky && source oe-init-build-env ..; git -C downloads status 2>&1 1>/dev/null  || git -C downloads -c init.defaultBranch=dummy init ; \
exec bash -c \"time eval ${1:-'bitbake -c cleanall trik-image-core trik-runtime-qt5;time bitbake trik-image-core -k'}\" \
"
popd
