#---
# name: build-essential
# group: build
# notes: installs compilers and build tools
#---
ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		  build-essential \
		  software-properties-common \
		  apt-transport-https \
		  ca-certificates \
		  lsb-release \
		  pkg-config \
		  gnupg \
		  git \
		  wget \
		  curl \
		  nano \
		  zip \
		  unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
    
RUN gcc --version && \
    g++ --version