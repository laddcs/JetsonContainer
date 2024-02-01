#!/bin/bash
#set -e

docker build . -f ./build-essential/Dockerfile --build-arg="BASE_IMAGE=nvcr.io/nvidia/l4t-base:r35.1.0" --tag=JetsonContainer/build-essential
docker build . -f ./python/Dockerfile --build-arg="BASE_IMAGE=JetsonContainer/build-essential" --tag=JetsonContainer/python

