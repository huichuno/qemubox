
FROM ubuntu:focal
LABEL maintainer="Hui Chun Ong"

ENV PACKAGES bc \
    bison \
    bridge-utils \
    build-essential \
    flex \
    gettext \
    git \
    libattr1-dev\
    libcap-dev \
    libdrm-dev \
    libegl-mesa0 \
    libgbm-dev\
    libgtk-3-dev \
    libusb-1.0-0-dev \
    libsdl2-dev \
    libspice-server-dev \
    libssl-dev \
    spice-client-gtk

ENV BUILD_ARG --enable-kvm \
    --audio-drv-list=pa \
    --disable-debug-tcg \
    --disable-xen \
    --enable-debug \
    --enable-debug-info \
    --enable-gtk \
    --enable-libusb \
    --enable-opengl \
    --enable-sdl \
    --enable-spice \
    --enable-vhost-net \
    --enable-virtfs \
    --target-list=x86_64-softmmu

RUN apt-get update && \
    apt-get -y -q upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -q install ${PACKAGES} && \
    apt-get clean

ENV BASE=/project/qemu
WORKDIR ${BASE}
RUN dpkg -l ${PACKAGES} | sort > packages.txt

COPY conf ${BASE}/conf 

RUN BRANCH=$(awk -F '=' '/^BRANCH/{print $NF}' ${BASE}/conf); \
    REPO_URL=$(awk -F '=' '/^REPO_URL/{print $NF}' ${BASE}/conf); \
    git config --global advice.detachedHead false && \ 
    git clone --depth 1 ${REPO_URL} --branch ${BRANCH} --single-branch src

COPY patches ${BASE}/patches

WORKDIR ${BASE}/src
RUN git apply ${BASE}/patches/*.patch &>/dev/null

WORKDIR ${BASE}/src/build
RUN BRANCH=$(awk -F '=' '/^BRANCH/{print $NF}' ${BASE}/conf); \
    ../configure --prefix=/usr ${BUILD_ARG} && \
    make -j `nproc` && \
    cd .. && tar -czvf qemu-${BRANCH}.tar.gz build/ && \
    mkdir /build && cp qemu-${BRANCH}.tar.gz /build
