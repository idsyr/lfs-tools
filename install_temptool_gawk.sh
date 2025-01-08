#!/bin/sh

cd $LFS/sources
LFS_TARGET=gawk
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

sed -i 's/extras//' Makefile.in

./configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install


