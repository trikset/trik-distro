First of all:
https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html
or read this short README up to the end, at least...

1. Long story short, to install build pre-requisites, run (for Debian/Ubuntu/Mint):

    ```shell
    sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool file locales libacl1
    sudo locale-gen en_US.UTF-8 
    ```

1. To download build metadata, do:

    ```shell
    git clone --depth 1 -b kirkstone git://git.yoctoproject.org/poky
    ```

    Now all config files and build scripts are present, and host is ready to start build. Rules for build are in 'sources' directory.
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


# Report all problems to issues section for this repo

-------

To build the whole image for microSD with TRIK firmware with support additonal programming languages such as C#,F#(mono), and erlang, run this:

	$ bitbake trik-image-langs

The command above also builds lots of additional packages, but not all. The first build of the whole image can take 4-8 hours, be prepared.
After build is complete image is ready in deploy/eglibc/images/trikboard/. Files with .trik-img extension are full microSD images.

To build cross-compiler SDK:

	$ bitbake meta-toolchain-trik

After successful SDK build run it to install:

	```# bash deploy/eglibc/sdk/trik-sdk-i686-armv5te-toolchain-trik-nodistro.0.sh```

NOTE: Elevated privelegies are required to install, use 'sudo', 'su', etc.
