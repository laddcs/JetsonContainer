#
# Dockerfile for building LADDCS ros packages for deployment
#

ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"] 

# Install the libirmanager from evocortex repo
WORKDIR /tmp
RUN sudo bash -c 'echo "options uvcvideo nodrop=1" > /etc/modprobe.d/uvcvideo.conf'
RUN apt-get update & apt-get install -y --no-install-recommends && \
    apt-get install -y --no-install-recommends\
        cmake \
        freeglut3-dev && \
    sudo wget http://ftp.evocortex.com/libirimager-8.9.0-arm64.deb && \
    dpkg -i libirimager-8.9.0-arm64.deb

RUN mkdir /DroneWorkspace

WORKDIR /DroneWorkspace

COPY /src/ /DroneWorkspace/

RUN source /opt/ros/humble/install/setup.bash && \
    colcon build \
    --event-handlers console_direct+