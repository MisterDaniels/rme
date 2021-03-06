FROM ubuntu:latest AS builder

ENV TZ=America/Sao_Paulo
ARG DOCKER_WORK_DIR

COPY . $DOCKER_WORK_DIR

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt install -y git cmake libboost-system-dev \
    libboost-thread-dev libglu1-mesa-dev \
    libwxgtk3.0-gtk3-dev libarchive-dev \
    freeglut3-dev libxmu-dev libxi-dev 