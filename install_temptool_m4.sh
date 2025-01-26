#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

LFS_TARGET=m4
select_lfs_build_target m4

./configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)

make -s
make -s DESTDIR=$LFS install


