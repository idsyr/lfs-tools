#!/bin/bash
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=xz

select_lfs_build_target ${LFS_TARGET}

./configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(build-aux/config.guess) \
--disable-static \
--docdir=/usr/share/doc/xz-5.6.2

make -s
make -s DESTDIR=$LFS install
rm -v $LFS/usr/lib/liblzma.la


