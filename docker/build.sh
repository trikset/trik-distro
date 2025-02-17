#!/bin/bash
set -xueo pipefail
pushd $(dirname $(realpath "$BASH_SOURCE"))
docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)"  -t oe-builder-yocto .
docker run --network=host -ti -v $PWD/..:/sandbox:rw -w /sandbox oe-builder-yocto bash -lc "\
set -xeo pipefail; \
pwd; \
cd poky && source oe-init-build-env ..; git -C downloads status 2>&1 1>/dev/null  || git -C downloads -c init.defaultBranch=dummy init ; \
time eval ${1:-'bitbake -c cleanall trik-image-core trik-runtime-qt5;time bitbake trik-image-core -k'} \
"
popd
