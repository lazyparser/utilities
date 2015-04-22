#!/bin/bash

set -e -x

# Check if openMEEG has been installed.
[ -f /usr/local/bin/om_assemble ] && exit 0

wget 'https://github.com/openmeeg/openmeeg/archive/master.zip'
	-O openmeeg-master.zip
unzip openmeeg-master.zip
cd openmeeg-master
mkdir build
cd build
cmake -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Release -DUSE_PROCESSBAR=ON -DENABLE_PYTHON=ON -DUSE_OMP=ON ..
make -j 12
#make est / check
make install
# fix ldconfig
grep -q '/usr/local/lib64' /etc/ld.so.conf || echo '/usr/local/lib64/' >> /etc/ld.so.conf
ldconfig

