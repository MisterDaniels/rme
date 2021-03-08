FROM ubuntu:latest AS builder

ENV TZ=America/Sao_Paulo
ARG DOCKER_WORK_DIR

COPY . $DOCKER_WORK_DIR

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -y git cmake libboost-system-dev \
    libboost-thread-dev libglu1-mesa-dev build-essential \
    libgtk2.0-dev libwxgtk3.0-gtk3-dev libarchive-dev \
    freeglut3-dev libxmu-dev libxi-dev wget libcanberra-gtk-module
RUN wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.4/wxWidgets-3.1.4.tar.bz2 && \
    tar -xf wxWidgets-3.1.4.tar.bz2 && cd wxWidgets-3.1.4 && mkdir gtk-build && cd gtk-build && \
    ../configure && make -j3 && make install && ldconfig
RUN cd $DOCKER_WORK_DIR && mkdir build && cd ./build && cmake .. && make -j `nproc`