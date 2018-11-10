FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
LABEL maintainer caffe-maint@googlegroups.com

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
	python-opencv \
        python-setuptools \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*

RUN pip install easydict
RUN pip install cython
RUN git clone --recursive https://github.com/phtruongan/py-faster-rcnn.git
RUN cd py-faster-rcnn/lib && make
RUN cd py-faster-rcnn/caffe-fast-rcnn && make && make pycaffe
RUN cd py-faster-rcnn && ./data/scripts/fetch_faster_rcnn_models.sh
 
