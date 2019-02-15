First of all:
	http://www.openembedded.org/wiki/Getting_started
or read this short README up to the end, at least...

1. Long story short, to install build pre-requisites, run (for Debian/Ubuntu/Mint):
	
	```shell
	$ sudo apt-get install python2.7-minimal gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath libsdl1.2-dev util-linux coreutils parted libtool lzop
		```


1. To configure the scripts and download the build metadata, do:

	$ ./oebb.sh config

1. If the previous step complains about dash/bash, please, do not ignore, otherwise it can result into problems with few packages. 

Now all config files and build scripts are present, and host is ready to start build. Rules for build are in 'sources' directory.
Main config is in  ./conf directory. For example, to build faster, change options in conf/local.conf:

       PARALLEL_MAKE     = "-j5"
       BB_NUMBER_THREADS = "5"

The number in this option mainly depends on number of available CPU cores on host (build) machine. We recommend ${NUM_CORES}+1.

1. For the first build and any later from now on, please use `bash`. And every time set environment variables in the build shell:

	```$ source ./build-environment-trik```

Do not forget to source enviromnent config (build-environment-trik) each time before new build in fresh terminal session.

1. Now environment is fully prepared to build any package. For example, use the following command to build Linux kernel

	```$ bitbake virtual/kernel```

It is strongly recommended to read short cheat-sheet on bitbake: http://elinux.org/Bitbake_Cheat_Sheet

1. To build the whole image for microSD with core TRIK firmware, run this:

```	$ bitbake trik-image-core```

-------

To build the whole image for microSD with TRIK firmware with support additonal programming languages such as C#,F#(mono), and erlang, run this:

	$ bitbake trik-image-langs

The command above also builds lots of additional packages, but not all. The first build of the whole image can take 4-8 hours, be prepared.
After build is complete image is ready in deploy/eglibc/images/trikboard/. Files with .trik-img extension are full microSD images.

To build cross-compiler SDK:

	$ bitbake meta-toolchain-trik

TODO: Why 'meta-'?

After successful SDK build run it to install:

	```# bash deploy/eglibc/sdk/trik-sdk-i686-armv5te-toolchain-trik-nodistro.0.sh```

NOTE: Elevated privelegies are required to install, use 'sudo', 'su', etc.


Additional useful things can be build by following names

mono
fsharp
roslaunch

TODO: Table of traditional packages' names mapping to reciepts' names to build. (inc JDK)
TODO: Explain commands. 'Build' is main command, but `bitbake' knows a lot. See sources/openembedded-core/meta/conf/documentation.conf for details
TODO: bitbake core-image-ros-roscore



We work hard improving TRIK firmware, stay tuned and use 
	$ git pull
	$ ./oebb.sh update
to get updates

NOTE: The oebb.sh script tries hard to keep your local changes while at the same time keeping close to the original config. Please keep the following in mind:

	* it will reset the origin URI based on layers.txt, so update layers.txt when changing a repo
	* it will do a 'git reset --hard <ref>' on locked down repos, so please create a new branch for your changes

-------
This script is based on Angstom setup-scripts
