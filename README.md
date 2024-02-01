# JetsonContainer
Repo that indexes ros packages for cross-compilation for Jetson

First you need to install and setup qemu:
```bash
sudo apt-get install qemu binfmt-support qemu-user-static
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```