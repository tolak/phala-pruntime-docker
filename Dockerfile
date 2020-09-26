FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
ADD ./dockerfile.d/00_aliyun_source.conf /etc/apt/sources.list

RUN apt update && apt upgrade -y && apt install -y autoconf automake bison build-essential cmake curl dpkg-dev expect flex gcc-8 gdb git git-core gnupg kmod libboost-system-dev libboost-thread-dev libcurl4-openssl-dev libiptcdata0-dev libjsoncpp-dev liblog4cpp5-dev libprotobuf-c0-dev libprotobuf-dev libssl-dev libtool libxml2-dev ocaml ocamlbuild pkg-config protobuf-compiler python sudo systemd-sysv texinfo uuid-dev vim wget software-properties-common lsb-release apt-utils binutils-dev nginx

ADD ./dockerfile.d/01_llvm_10.sh /root
RUN bash /root/01_llvm_10.sh

ENV BINUTILS_PREFIX=/usr

ADD ./dockerfile.d/03_sdk.sh /root
RUN bash /root/03_sdk.sh

# Sixth, PSW

# ENV CODENAME        bionic
# ENV VERSION         2.9.101.2-bionic1

# ADD ./dockerfile.d/04_psw.sh /root
# RUN bash /root/04_psw.sh

# Seventh, Rust

ENV rust_toolchain  nightly
ADD ./dockerfile.d/05_rust.sh /root
RUN bash /root/05_rust.sh
ADD ./dockerfile.d/06_wasm.sh /root
RUN bash /root/06_wasm.sh

ENV DEBIAN_FRONTEND=''
ENV CODENAME=''
ENV VERSION=''
ENV PATH=$PATH:$HOME/.cargo/bin 
ENV SGX_SDK=/opt/sgxsdk

WORKDIR /root

# for TEE web service
EXPOSE 9711
