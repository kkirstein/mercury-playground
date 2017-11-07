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
RUN mkdir -p /var/tmp/mercury && \
	cd /var/tmp/mercury && \
	wget --no-verbose http://dl.mercurylang.org/rotd/mercury-srcdist-rotd-$MERCURY_VERSION.tar.gz -O ./mercury-rotd.tar.gz && \
	tar xvf mercury-rotd.tar.gz

WORKDIR /var/tmp/mercury/mercury-srcdist-rotd-$MERCURY_VERSION

# configure & build Mercury
RUN ./configure --disable-most-grades && \
	make PARALLEL=-j4 install



