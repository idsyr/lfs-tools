#!/bin/sh

cd $LFS/sources
LFS_TARGET=mpfr
tar -xf $LFS_TARGET*tar*
mv $LFS_TARGET*/ $LFS_TARGET/

LFS_TARGET=gmp
tar -xf $LFS_TARGET*tar*
mv $LFS_TARGET*/ $LFS_TARGET/

LFS_TARGET=mpc
tar -xf $LFS_TARGET*tar*
mv $LFS_TARGET*/ $LFS_TARGET/

LFS_TARGET=gcc
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir build
cd build

../configure \
--build=$(../config.guess) \
--host=$LFS_TGT \
--target=$LFS_TGT \
LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
--prefix=/usr \
--with-build-sysroot=$LFS \
--enable-default-pie \
--enable-default-ssp \
--disable-nls \
--disable-multilib \
--disable-libatomic \
--disable-libgomp \
--disable-libquadmath \
--disable-libsanitizer \
--disable-libssp \
--disable-libvtv \
--enable-languages=c,c++ \

make
make DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc

cd ..

