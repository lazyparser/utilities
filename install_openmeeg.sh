#!/bin/bash

set -e -x

if [ $UID -ne 0 ]; then
echo "Run me as root."
exit 1
fi
n_cores=`cat /proc/cpuinfo | grep cores | wc -l`
# Check if openMEEG has been installed.
[ -f /usr/local/bin/om_assemble ] && exit 0

# download it from github using zip, since this is more
# stable than git-related-methods.
# Life in mainland China, as a programmer, is not easy :-(
wget 'https://github.com/openmeeg/openmeeg/archive/master.zip'
	-O openmeeg-master.zip
unzip openmeeg-master.zip
cd openmeeg-master
mkdir build
cd build
cmake -DBUILD_TESTING=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DUSE_PROCESSBAR=ON \
	-DENABLE_PYTHON=ON \
	-DUSE_OMP=ON ..
make -j $n_cores
# make est / check
make install
# fix ldconfig
grep -q '/usr/local/lib64' /etc/ld.so.conf || echo '/usr/local/lib64/' >> /etc/ld.so.conf
ldconfig

# test it
om_assemble

