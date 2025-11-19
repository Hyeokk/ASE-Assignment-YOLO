FROM ubuntu:20.04


ENV TZ=Asia/Seoul
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        libopencv-dev \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/pjreddie/darknet && \
    cd darknet && \
    make && \
    wget https://data.pjreddie.com/files/yolov3.weights

COPY detect.sh /usr/local/bin/detect
RUN chmod +x /usr/local/bin/detect
ENTRYPOINT [ "detect" ]