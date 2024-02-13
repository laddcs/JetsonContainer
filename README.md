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
sudo docker run --rm --runtime nvidia --device=/dev/ttyUSB0 -it YOUR-USERNAME/BUILT-IMAGE
```

Note when runnint on x86 host, there is an issue with cyclonedds discovering ports so ros might not be functional in container.