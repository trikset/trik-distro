#!/bin/sh
set -xueo pipefail
pushd $(dirname $(realpath "$BASH_SOURCE"))
docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)"  -t oe-builder . 
docker run -ti -v $PWD/..:/sandbox:rw -w /sandbox oe-builder bash -lc "\
set -xeo pipefail; \
pwd; \
if [ ! -d 'poky' ]; then git clone --depth 1 -b kirkstone git://git.yoctoproject.org/poky; fi && cd poky && source oe-init-build-env ..; \
time eval ${1:-'bitbake -c cleanall trik-image-core trik-runtime-qt5;time bitbake trik-image-core -k'} \
"
#sudo chown -cR --from root:root $USER:$USER .
popd
