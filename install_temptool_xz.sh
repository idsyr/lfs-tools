#!/bin/sh

cd $LFS/sources
LFS_TARGET=xz
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

./configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(build-aux/config.guess) \
--disable-static \
--docdir=/usr/share/doc/xz-5.6.2

make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/liblzma.la


