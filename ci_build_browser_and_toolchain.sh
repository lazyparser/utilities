#!/bin/bash

cd $HOME/farm/chromium/src && make -j 8 \
	&& touch $HOME/`date +%F`.chromium.SUCCESS \
	|| touch $HOME/`date +%F`.chromium.FAIL
cd $HOME/farm/mozilla-central && hg pull -u && make -f client.mk -j 8 \
	&& touch $HOME/`date +%F`.firefox.SUCCESS \
	|| touch $HOME/`date +%F`.firefox.FAIL
cd $HOME/farm/gcc-trunk && svn up && \
	cd ../build-gcc/ && ../gcc-trunk/configure --prefix=$HOME/bin/ --enable-lanuages=c \
	make -j 8 && make install \
	&& touch $HOME/`date +%F`.gcc.SUCCESS \
	|| touch $HOME/`date +%F`.gcc.FAIL
cd $HOME/farm/llvm-trunk && svn up && \
	cd ../build-llvm/ && ../llvm-trunk/configure --prefix=$HOME/bin/ && \
	make -j 8 && make install \
	&& touch $HOME/`date +%F`.llvm.SUCCESS \
	|| touch $HOME/`date +%F`.llvm.FAIL

