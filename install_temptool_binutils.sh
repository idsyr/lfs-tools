#!/bin/bash
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=binutils

select_lfs_build_target $LFS_TARGET

sed '6009s/$add_dir//' -i ltmain.sh

mkdir -p build && cd build

../configure \
--prefix=/usr \
--build=$(../config.guess) \
--host=$LFS_TGT \
--disable-nls \
--enable-shared \
--enable-gprofng=no \
--disable-werror \
--enable-64-bit-bfd \
--enable-new-dtags \
--enable-default-hash-style=gnu

make -s
make -s DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}


