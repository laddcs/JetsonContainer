#
# Docker file to build and install eProsima fastdds
#

ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

RUN apt-get update & apt-get install -y --no-install-recommends

# Install Fast-DDS 2.3.1
RUN rm -rf /usr/local/include/fastrtps /usr/local/share/fastrtps /usr/local/lib/libfastrtps* \
	&& git clone --recursive https://github.com/eProsima/Micro-XRCE-DDS-Agent.git /tmp/Micro-XRCE-DDS-Agent \
	&& cd /tmp/Micro-XRCE-DDS-Agent \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make && make install \
	&& ldconfig /usr/local/lib/