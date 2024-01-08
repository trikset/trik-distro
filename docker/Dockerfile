FROM ubuntu:jammy
MAINTAINER Iakov Kirilenko <Iakov.Kirilenko@trikset.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get dist-upgrade -y \
	&& apt-get install -y --no-install-recommends \
		locales python3-pip gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath libsdl1.2-dev util-linux coreutils parted libtool lzop cpio \
    screen tmux vim-tiny \
    git gcc socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa python3-subunit \
    mesa-common-dev zstd liblz4-tool file locales libacl1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
            /var/cache/debconf/* \
            /usr/share/doc \
            /usr/share/man \
            /usr/share/locale/?? \
            /usr/share/locale/??_??

RUN echo ---
RUN locale-gen --purge en_US.UTF-8
RUN pip3 install -U 'pip < 21' && pip3 install -U setuptools wheel && pip3 install -U pytest-shutil

RUN echo "dash dash/sh boolean false" | debconf-set-selections ; dpkg-reconfigure -f noninteractive dash || :
ARG host_uid=1001
ARG host_gid=1001
RUN mkdir /sandbox
RUN groupadd -g $host_gid sandbox && \
    useradd -g $host_gid -M -s /bin/bash -u $host_uid sandbox && chown sandbox:sandbox /sandbox || true
USER $host_uid
ENV LANG=en_US.UTF-8

RUN du -csh /* 2>/dev/null | sort -h || :
