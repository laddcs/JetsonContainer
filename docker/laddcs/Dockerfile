#
# Dockerfile for building LADDCS ros packages for deployment
#

ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"] 

COPY /docker/laddcs/entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

RUN mkdir /DroneWorkspace

COPY /src/ /DroneWorkspace/

ARG USERNAME=devuser
ARG UID=1000
ARG GID=${UID}

RUN groupadd --gid $GID $USERNAME \
 && useradd --uid ${GID} --gid ${UID} --create-home ${USERNAME} \
 && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME} \
 && mkdir -p /home/${USERNAME} \
 && chown -R ${UID}:${GID} /home/${USERNAME} \ 
 && usermod -a -G dialout ${USERNAME} \
 && usermod -a -G video ${USERNAME}

 # Set the ownership of the overlay workspace to the new user
RUN chown -R ${UID}:${GID} /DroneWorkspace/
RUN sudo bash -c 'echo "options uvcvideo nodrop=1" > /etc/modprobe.d/uvcvideo.conf'

USER ${USERNAME}

WORKDIR /DroneWorkspace
RUN source /opt/ros/humble/install/setup.bash && \
    colcon build \
    --event-handlers console_direct+

