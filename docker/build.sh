#!/bin/bash
pushd $(dirname $(realpath "$BASH_SOURCE"))
docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)"  -t oe-builder . 
docker run -ti -v $PWD/..:/sandbox:rw -w /sandbox oe-builder bash -lc "${1:-\
set -xueo pipefail; \
pwd; \
echo ./oebb.sh config; \
source build-environment-trik; \
echo bitbake -c cleanall trik-image-core trik-runtime-qt5; \
time bitbake trik-image-core -k \
}"
#sudo chown -cR --from root:root $USER:$USER .
popd
