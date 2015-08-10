FROM ubuntu:14.04
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    bison \
    bzip2 \
    flex \
    g++ \
    gawk \
    gcc \
    git \
    gperf \
    libexpat-dev \
    libtool \
    make \
    ncurses-dev \
    nano \
    python \
    python-pip \
    sed \
    texinfo \
    unrar-free \
    unzip \
    wget \
    screen

# Building the SDK as root is not allowed, so we add a user for it.
RUN adduser --system --no-create-home builder

RUN chown builder /opt
USER builder
WORKDIR /opt
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git

WORKDIR /opt/esp-open-sdk

RUN make STANDALONE=n

USER root
WORKDIR /opt/esp-open-sdk/esptool
RUN python setup.py install

WORKDIR /opt
ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/opt/esp-open-sdk/esptool/:$PATH
ENV SDK_BASE /opt/esp-open-sdk/esp_iot_sdk_v1.2.0
ENV XTENSA_TOOLS /opt/esp-open-sdk/xtensa-lx106-elf/bin
