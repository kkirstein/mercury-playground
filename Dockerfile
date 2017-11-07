# vim: sw=4 ts=4
# Use an offical Ubuntu
FROM ubuntu:latest

LABEL maintainer="Kay-Uwe Kirstein <kay-uwe@kirsteinhome.ch>"

# Install dependencies
RUN apt-get update && apt-get install -y \
	apt-utils \
	wget \
	binutils \
	make \
	libreadline-dev \
	flex \
	bison

ENV MERCURY_VERSION 2017-10-24

# Get ROTD Mercury version
RUN mkdir -p /tmp/mercury && \
	cd /tmp/mercury && \
	wget --no-verbose http://dl.mercurylang.org/rotd/mercury-srcdist-rotd-$MERCURY_VERSION.tar.gz -O ./mercury-rotd.tar.gz && \
	tar xvf mercury-rotd.tar.gz

WORKDIR /tmp/mercury/mercury-srcdist-rotd-$MERCURY_VERSION

# configure & build Mercury
RUN ./configure --disable-most-grades && \
	make PARALLEL=-j4 install

# setup non-root user
RUN useradd -d /home/mercury -m -s /bin/bash mercury && \
	passwd -l mercury && \
	chown -R mercury:mercury /home/mercury

USER mercury
ENV HOME /home/mercury
WORKDIR /home/mercury
