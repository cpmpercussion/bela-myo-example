#!/bin/bash
unzip MyoLinux.zip
cd MyoLinux-master
mkdir build
cd build
cmake ..
make
make install
cp /usr/local/lib/libmyolinux.so /usr/lib/.
echo "done setting up myolinux."
