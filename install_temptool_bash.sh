#!/bin/sh 

cd $LFS/sources
LFS_TARGET=bash
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

./configure \
--prefix=/usr \
--build=$(sh support/config.guess) \
--host=$LFS_TGT \
--without-bash-malloc \
bash_cv_strtold_broken=no

make
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh


