#!/bin/sh 

cd $LFS/sources
LFS_TARGET=gzip
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

./configure --prefix=/usr --host=$LFS_TGT
make
make DESTDIR=$LFS install


