#!/usr/bin/env bash

# install and/or reload ntp daemon
apt-get update

apt-get -y install ntp
service ntp reload

# setup correct timezone
echo "Europe/Zurich" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# install mercury ROTD
echo ""
echo Installing dependencies
echo =======================
apt-get -y install flex
apt-get -y install bison

echo ""
echo Downloading mercury-ROTF
echo ========================
rotd="2015-11-16"
curl --silent --insecure http://dl.mercurylang.org/rotd/mercury-srcdist-rotd-${rotd}.tar.gz -O
tar -xf mercury-srcdist-rotd-${rotd}.tar.gz
chown -R vagrant mercury-srcdist-${rotd}

echo ""
echo Build mercury
echo =============
cd mercury-srcdist-rotd-${rotd}
./configure --disable-most-grades
make PARALLEL=-j2 install

if [ ! `which mmc` ]; then
	echo 'export PATH=$PATH:/usr/local/mercury-rotd-${rotd}/bin' >> /etc/profile
fi


