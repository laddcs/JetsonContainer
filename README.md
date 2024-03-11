# JetsonContainer
Repo that indexes ros packages for cross-compilation for Jetson

First you need to install and setup qemu:
```bash
sudo apt-get install qemu binfmt-support qemu-user-static
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

Build the base container:
```bash
cd docker
sudo bash ./build.sh
``` 

Push the container to Docker Hub:
```bash
docker login -u YOUR-USERNAME
docker tag BUILT-IMAGE:latest YOUR-USERNAME/BUILT-IMAGE
docker push YOUR-USERNAME/BUILT-IMAGE
```

Run the container on the Jetson using:
```bash
sudo docker run --rm --runtime nvidia -it YOUR-USERNAME/BUILT-IMAGE
```

To bind ports to container use:
```bash
sudo docker run --rm --runtime nvidia --device=/dev/ttyUSB0 --device=/dev/video0 --privlaged -it YOUR-USERNAME/BUILT-IMAGE
```
For libirimager to work properly the container must be running as privlaged.

Note when runnint on x86 host, there is an issue with cyclonedds discovering ports so ros might not be functional in container.

Ethernet Setup:
Want to set the px4 ip address to 192.168.0.4 with dds on port 8888, and set the Jetson ethernet to a static ip 192.168.0.1

PX4 Side:
Need to set up ethernet port to connect to network
In QGroundControl go to mavlink shell and enter
```bash
echo DEVICE=eth0 > /fs/microsd/net.cfg
echo BOOTPROTO=static >> /fs/microsd/net.cfg
echo IPADDR=192.168.0.4 >> /fs/microsd/net.cfg
echo NETMASK=255.255.255.0 >>/fs/microsd/net.cfg
echo ROUTER=192.168.0.254 >>/fs/microsd/net.cfg
echo DNS=192.168.0.254 >>/fs/microsd/net.cfg
```
Then enter
```bash
netman update -i eth0
```
The Pixhawk will restart.

Then go to parameters and under UXRCE-DDS-Client set UXCRE_DDS_CFG=Ethernet, UXRCE_DDS_AG_IP=-1062731775 (this is 192.168.0.1 as an int), and UXCRE_DDS_PRT=8888. Reboot Pixhawk

Jetson Side:
Open a terminal and enter
```bash
sudo ip link set eth0 down
sudo ip addr add 192.168.0.1/24 dev eth0
sudo ip link set eth0 up
```

Connect the ethernet cable and enter
```bash
ping 192.168.0.4
```
to check if the computers are connected.

Launch the container with the port forwarded as follows:
```bash
sudo docker run --rm --runtime nvidia --device=/dev/ttyUSB0 --device=/dev/video0 -p 8888:8888/udp --privlaged -it YOUR-USERNAME/BUILT-IMAGE
```