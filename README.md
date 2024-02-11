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