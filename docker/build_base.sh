#!/bin/bash
#set -e

# Builds the base layer container
# This takes a very long time to do from scratch, just pull from docker hub

docker build . -f ./build-essential/Dockerfile --build-arg="BASE_IMAGE=nvcr.io/nvidia/l4t-base:r36.2.0" --tag=JetsonContainer/build-essential

docker build . -f ./python/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/build-essential" --tag=JetsonContainer/python

docker build . -f ./numpy/Dockerfile --build-arg "BASE_IMAGE=JetsonContainer/python" --tag=JetsonContainer/numpy

docker build . -f ./cmake/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/numpy" --tag=JetsonContainer/cmake

docker build . -f ./cuda/cuda/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/cmake" --build-arg="CUDA_URL=https://nvidia.box.com/shared/static/uvqtun1sc0bq76egarc8wwuh6c23e76e.deb" --build-arg="CUDA_DEB=cuda-tegra-repo-ubuntu2204-12-2-local" --build-arg="CUDA_PACKAGES=cuda-toolkit*" --tag=JetsonContainer/cuda

docker build . -f ./cuda/cudnn/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/cuda" --build-arg="CUDNN_URL=https://nvidia.box.com/shared/static/ht4li6b0j365ta7b76a6gw29rk5xh8cy.deb" --build-arg="CUDNN_DEB=cudnn-local-tegra-repo-ubuntu2204-8.9.4.25" --build-arg="CUDNN_PACKAGES=libcudnn*-dev libcudnn*-samples" --tag=JetsonContainer/cudnn

docker build . -f ./tensorrt/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/cudnn" --build-arg="TENSORRT_URL=https://nvidia.box.com/shared/static/hmwr57hm88bxqrycvlyma34c3k4c53t9.deb" --build-arg="TENSORRT_DEB=nv-tensorrt-local-repo-l4t-8.6.2-cuda-12.2" --build-arg="TENSORRT_PACKAGES=tensorrt tensorrt-libs python3-libnvinfer-dev" --tag=JetsonContainer/tensorrt

docker build . -f ./gstreamer/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/tensorrt" --tag=JetsonContainer/gstreamer

docker build . -f ./jetson-utils/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/gstreamer" --tag=JetsonContainer/jetson-utils

docker build . -f ./opencv/opencv_builder/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/jetson-utils" --build-arg="ENABLE_OPENGL=OFF" --build-arg="ENABLE_NEON=ON" --build-arg="CUDA_ARCH_BIN=8.7" --build-arg="OPENCV_VERSION=4.8.1" --tag=JetsonContainer/opencv-build

docker build . -f ./ros/Dockerfile.ros2 --build-arg="BASE_IMAGE=JetsonContainer/opencv-build" --tag=JetsonContainer/ros2-humble

docker build . -f ./drone-deploy/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/ros2-humble" --tag=JetsonContainer/drone-base

# docker build . -f ./laddcs/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/drone-base" --tag=Jetsoncontainer/laddcs-deploy