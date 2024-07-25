FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y --no-install-recommends gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1
RUN locale-gen en_US.UTF-8
ARG host_uid=1001
ARG host_gid=1001
RUN mkdir /sandbox
RUN groupadd -g $host_gid sandbox && useradd -g $host_gid -M -s /bin/bash -u $host_uid sandbox && chown sandbox:sandbox /sandbox
USER $host_uid
