FROM debian:jessie
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

RUN apt-get update && apt-get -y install \
  automake \
  autogen \
  bash \
  build-essential \
  bzip2 \
  curl \
  file \
  git \
  gzip \
  libssl-dev \
  make \
  ncurses-dev \
  ninja-build \
  pkg-config \
  rsync \
  sed \
  tar \
  vim \
  wget \
  xz-utils

# Build and install CMake from source.
WORKDIR /usr/src
# nighty-master 2015-05-04
RUN git clone git://cmake.org/cmake.git CMake && \
  cd CMake \
  && git checkout 6cd6d50871ce28d0c72336a6aca01814487df5e1
RUN mkdir CMake-build
WORKDIR /usr/src/CMake-build
RUN /usr/src/CMake/bootstrap \
    --parallel=$(nproc) \
    --prefix=/usr && \
  make -j$(nproc) install && \
  rm -rf *
