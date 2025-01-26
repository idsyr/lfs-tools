#!/bin/bash 
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=gcc

select_lfs_build_target ${LFS_TARGET}
 
tar -xf ../mpfr*tar* && mv mpfr*/ mpfr/ # Unpack each package into the GCC source directory 
tar -xf ../gmp*tar*  && mv gmp*/  gmp/  # and rename the resulting directories so
tar -xf ../mpc*tar*  && mv mpc*/  mpc/  # the GCC build procedures will automatically use them

case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -p build && cd build

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

make -s
make -s DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc

