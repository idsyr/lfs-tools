#!/bin/sh
 
cd $LFS/sources
LFS_TARGET=file
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

mkdir build
pushd build
    ../configure \
    --disable-bzlib \
    --disable-libseccomp \
    --disable-xzlib \
    --disable-zlib
    make
popd

./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

make FILE_COMPILE=$(pwd)/build/src/file
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/libmagic.la


