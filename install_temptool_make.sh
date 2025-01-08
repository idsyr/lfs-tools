#!/bin/sh
cd $LFS/sources
LFS_TARGET=make
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

./configure \
--prefix=/usr \
--without-guile \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install


