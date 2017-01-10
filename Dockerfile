FROM ubuntu:16.10
RUN apt update && apt install -y \
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
    help2man \
    libexpat-dev \
    libtool \
    libtool-bin \
    make \
    nano \
    ncurses-dev \
    python \
    python-dev \
    python-pip \
    python-serial \
    screen \
    sed \
    texinfo \
    unrar-free \
    unzip \
    wget

# Building the SDK as root is not allowed, so we add a user for it.
RUN adduser --system --no-create-home builder
RUN chown builder /opt
USER builder
WORKDIR /opt
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
WORKDIR /opt/esp-open-sdk
RUN git reset --hard e8d757b1a70a5cf19df0afe23a769739c6cff343

RUN make STANDALONE=y

USER root
WORKDIR /opt/esp-open-sdk/esptool
RUN python setup.py install

WORKDIR /opt
ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/opt/esp-open-sdk/esptool/:$PATH
ENV SDK_BASE /opt/esp-open-sdk/esp_iot_sdk_v1.4.0
ENV XTENSA_TOOLS /opt/esp-open-sdk/xtensa-lx106-elf/bin
ENV DEFAULT_BAUDRATE 115200
