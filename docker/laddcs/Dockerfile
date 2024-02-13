#
# Dockerfile for building LADDCS ros packages for deployment
#

ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"] 

RUN mkdir /DroneWorkspace

WORKDIR /DroneWorkspace

COPY /src/ /DroneWorkspace/

RUN source /opt/ros/humble/install/setup.bash && \
    colcon build \
    --merge-install