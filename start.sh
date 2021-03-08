#!/bin/bash

# Run client in docker (dev)
xhost +

docker run -it --rm \
    --entrypoint ./rme/build/rme \
    --env DISPLAY \
    --net=host \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri \
    --device /dev/snd rme_builder

xhost -