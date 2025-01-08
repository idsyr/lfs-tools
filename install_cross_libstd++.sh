#!/bin/sh 
cd $LFS/sources
LFS_TARGET=gcc
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

mkdir build
cd build

../configure \
--prefix=$LFS/tools \
--with-sysroot=$LFS \
--target=$LFS_TGT \
--disable-nls \
--enable-gprofng=no \
--disable-werror \
--enable-new-dtags \
--enable-default-hash-style=gnu

make
make DESTDIR=$LFS isntall
rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la


