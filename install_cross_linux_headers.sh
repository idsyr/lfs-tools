#!/bin/sh 
cd $LFS/sources
LFS_TARGET=linux
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr


