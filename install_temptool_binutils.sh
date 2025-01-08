#!/bin/sh

cd $LFS/sources
LFS_TARGET=binutils
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

sed '6009s/$add_dir//' -i ltmain.sh

mkdir build
cd build

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

make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

cd ..

