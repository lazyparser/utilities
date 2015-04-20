#!/bin/bash

set -e -x

TIMESTAMP=`date +%Y%m%d`

# Sadly, we people live in mainland China are not able to download files from amazonaws
## Download & Install EmSDK
#wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
#tar xf emsdk-portable.tar.zg
#cd emsdk-portable/
#./emsdk update
#./emsdk install latest
#./emsdk activate latest
#. ./emsdk_env.sh
#cd ..

# Building related tools.
sudo apt-get update
sudo apt-get -y install build-essential cmake python2.7 nodejs default-jre
#sudo apt-get install git-core

# Download Emscripten
# FIXME: Thanks to GFW the TLS complains cert error when using git. Downloading zip files instead.
wget https://github.com/kripken/emscripten/archive/master.zip -O emscripten-$TIMESTAMP.zip
wget https://github.com/kripken/emscripten-fastcomp/archive/master.zip -O fastcomp-$TIMESTAMP.zip
wget https://github.com/kripken/emscripten-fastcomp-clang/archive/master.zip -O fastcomp-clang-$TIMESTAMP.zip

unzip emscripten-$TIMESTAMP.zip
unzip fastcomp-$TIMESTAMP.zip
unzip fastcomp-clang-$TIMESTAMP.zip
mv emscripten-fastcomp-clang-master emscripten-fastcomp-master/tools/clang
cd emscripten-fastcomp-master/
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="X86;JSBackend" -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF -DCLANG_INCLUDE_EXAMPLES=OFF -DCLANG_INCLUDE_TESTS=OFF
make -j 8

# Configure ~/.emscripten
[ -e ~/.emscripten ] && mv -f ~/.emscripten{,.old}
cat<<EOF > ~/.emscripten
# .emscripten file from Linux SDK

import os
SPIDERMONKEY_ENGINE = ''
NODE_JS = 'nodejs'
LLVM_ROOT="$PWD/bin"
EMSCRIPTEN_ROOT="$PWD/../../emscripten-master/"
V8_ENGINE = ''
TEMP_DIR = '/tmp'
COMPILER_ENGINE = NODE_JS
JS_ENGINES = [NODE_JS]
EOF

# Verify
cd ../../emscripten-master/
./emcc --help

echo "Done."

