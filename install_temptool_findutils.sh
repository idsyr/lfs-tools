#!/bin/sh 

cd $LFS/sources
LFS_TARGET=findutils
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

./configure \
--prefix=/usr \
--localstatedir=/var/lib/locate \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install


