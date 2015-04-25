#!/bin/bash
# For CentOS 6.x

if [ $UID -ne 0 ]; then
echo "Run me as root."
exit 1
fi

set -e -x

mkdir deeto_build
cd deeto_build
build_dir=`pwd`
n_cores=`cat /proc/cpuinfo | grep cores | wc -l`

# Prerequirments
# cmake >= 2.8
yum install cmake
# vtk >= 5.6
yum install vtk vtk-devel

# itk < 4.3, so compile it
cd $build_dir
wget 'http://downloads.sourceforge.net/project/itk/itk/4.7/InsightToolkit-4.7.1.tar.gz' \
	-O InsightToolkit-4.7.1.tar.gz
tar xf InsightToolkit-4.7.1.tar.gz
cd ./InsightToolkit-4.7.1/
mkdir build
cd build
cmake ..
make -j $n_cores
make install

# we don't have rpms for tclap, so just build it. 
cd $build_dir
wget 'http://downloads.sourceforge.net/project/tclap/tclap-1.2.1.tar.gz' \
	-O tclap-1.2.1.tar.gz
tar xf tclap-1.2.1.tar.gz
cd ./tclap-1.2.1/
./configure
make -j $n_cores
make install

cd $build_dir
wget 'https://github.com/mnarizzano/DEETO/archive/master.zip' \
	-O DEETO-master.zip
unzip DEETO-master.zip
cd DEETO-master/
cmake CMakeLists.txt
make -j $n_cores
make install

deeto --version
echo "Succeed."

