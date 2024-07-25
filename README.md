# Build firmware for the TRIK controller using the Yocto Project.

To build the firmware, you need to clone this repository and pull all the submodules:

```shell
$ git submodule update --init
$ git submodule update --remote
```

First of all:
https://docs.yoctoproject.org/4.0.19/brief-yoctoprojectqs/#
or read this short README up to the end, at least...

1. To install build pre-requisites, run (for Debian/Ubuntu/Mint):

    ```shell
    $ sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1

    $ sudo locale-gen en_US.UTF-8 
    ```

1. You need to clone the Poky repository to get all the necessary Yocto Project tools:

    ```shell
    $ git clone --depth 1 -b kirkstone git://git.yoctoproject.org/poky
    ```

    Now host is ready to start build. Rules for build are in 'sources' directory.
    Main config is in  ./conf directory. For example, to build faster, change options in conf/local.conf:

       PARALLEL_MAKE     = "-j5"
       BB_NUMBER_THREADS = "5"

    The number in this option mainly depends on number of available CPU cores on host (build) machine. We recommend ${NUM_CORES}+1.

1. For the first build and any later from now on, please use `bash`. And every time set environment variables in the build shell:
  
    ```$ source ./poky/oe-init-build-env .```
  
    Do not forget to source environment config (`oe-init-build-env`) each time before new build in fresh terminal session.

1. Now environment is fully prepared to build any package. For example, use the following command to build Linux kernel

    ```$ bitbake virtual/kernel```

    It is strongly recommended to read short cheat-sheet on bitbake: http://elinux.org/Bitbake_Cheat_Sheet

1. To build the whole image for microSD with core TRIK firmware, run this:

    ```$ bitbake trik-image-core```

## Build using a docker container.
There is a script in the docker directory `build.sh` to automatically clone the poky repository and launch the docker container using `Dockerfile`, which will build the docker image and download all the necessary packages for development.

This approach is suitable if you have an old or unsuitable operating system on host.

You can run the build image for microSD with core TRIK firmware:

```$ docker/build.sh```

or you can launch the docker container terminal and run the build using bitbake:

```shell
$ docker/build.sh bash
$ bitbake trik-image-core
```


# Report all problems to issues section for this repo.
