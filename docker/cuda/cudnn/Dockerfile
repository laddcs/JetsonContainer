#---
# name: cudnn
# group: cuda
# depends: cuda
# config: config.py
# test: test.sh
#---
ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ARG CUDNN_URL
ARG CUDNN_DEB
ARG CUDNN_PACKAGES

RUN echo "Downloading ${CUDNN_DEB}" && \
    mkdir /tmp/cudnn && cd /tmp/cudnn && \
    wget --quiet --show-progress --progress=bar:force:noscroll ${CUDNN_URL} && \
    dpkg -i *.deb && \
    cp /var/cudnn-local-tegra-repo-*/cudnn-local-tegra-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-cache search cudnn && \
    apt-get install -y --no-install-recommends ${CUDNN_PACKAGES} && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    dpkg --list | grep cudnn && \
    dpkg -P ${CUDNN_DEB} && \
    rm -rf /tmp/cudnn
    
RUN cd /usr/src/cudnn_samples_v8/conv_sample/ && \
    make -j$(nproc)