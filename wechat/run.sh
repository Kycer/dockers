#!/bin/bash

xhost +
sudo docker run \
    --privileged \
    --hostname=weixin \
    --name=weixin \
    --rm \
    --ipc=host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v $HOME/.config/weixin:/home/weixin/.config/weixin \
    kycer/wechat
xhost -