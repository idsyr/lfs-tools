#!/bin/bash
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=patch

select_lfs_build_target $LFS_TARGET

./configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)

make -s
make -s DESTDIR=$LFS install


