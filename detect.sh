#!/usr/bin/env bash
set -e

IMG_URL="$1"

if [ -z "$IMG_URL" ]; then
    echo "Usage: docker run <image-name> <image_url>"
    exit 1
fi

cd /darknet

echo "Downloading image from: $IMG_URL"
wget -q -O input.jpg "$IMG_URL"

if [ ! -f input.jpg ]; then
    echo "Failed to download image"
    exit 1
fi

echo "Running YOLOv3 detection..."
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg -dont_show
