ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"] 

# Install libirmanager from evocortex
WORKDIR /tmp
RUN sudo apt-get update -y \
    && apt-get install -y --no-install-recommends\
        cmake \
		udev \
		kmod \
		build-essential \
        freeglut3-dev \
        libusb-1.0-0-dev \
	&& wget http://ftp.evocortex.com/libirimager-8.9.0-arm64.deb \
	&& bash -c 'echo "options uvcvideo nodrop=1" > /etc/modprobe.d/uvcvideo.conf' \
	&& dpkg -i libirimager-8.9.0-arm64.deb

RUN sudo apt-get update -y \
    && git clone https://github.com/libuvc/libuvc \
    && cd libuvc \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make && sudo make install 
    
WORKDIR /

# Copy in calibration data for the optris
COPY /data/Optris_Cali /usr/share/libirimager/cali

RUN mkdir temp_ws
WORKDIR /temp_ws

RUN sudo apt-get update -y \
    && git clone -b humble https://github.com/micro-ROS/micro_ros_msgs.git \
    && git clone -b humble https://github.com/micro-ROS/micro-ROS-Agent.git \
    && git clone -b release/1.14 https://github.com/PX4/px4_msgs.git \
    && source /opt/ros/humble/install/setup.bash \
    && colcon build --event-handlers console_direct+ --install-base /opt/ros/humble/install/ --merge-install
    
WORKDIR /
RUN rm -rf temp_ws
