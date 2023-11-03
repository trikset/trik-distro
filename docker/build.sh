#!/bin/bash
set -xueo pipefail
pushd $(dirname $(realpath "$BASH_SOURCE"))
docker build --pull --network host --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)"  -t oe-builder .
docker run -ti --network host -v $PWD/..:/sandbox:rw -w /sandbox oe-builder bash -lc "\
set -xueo pipefail; \
pwd; \
[ ! -r build-environment-trik ] && ./oebb.sh config; source build-environment-trik; \
time eval ${1:-'bitbake -c cleanall trik-image-core trik-runtime-qt5;time bitbake trik-image-core -k'} \
"
#sudo chown -cR --from root:root $USER:$USER .
popd
