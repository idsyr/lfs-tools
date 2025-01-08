#!/bin/sh 

cd $LFS/sources

tar -xf mpfr*tar*
mv mpfr*/ mpfr/

tar -xf gmp*tar*
mv gmp*/ gmp/

tar -xf mpc*tar*
mv mpc*/ mpc/


LFS_TARGET=gcc
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/


# set default directory name for 64-bit libs to "lib"
case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
esac

mkdir build
cd build

../configure \
--target=$LFS_TGT \
--prefix=$LFS/tools \
--with-glibc-version=2.40 \
--with-sysroot=$LFS \
--with-newlib \
--without-headers \
--enable-default-pie \
--enable-default-ssp \
--disable-nls \
--disable-shared \
--disable-multilib \
--disable-threads \
--disable-libatomic \
--disable-libgomp \
--disable-libquadmath \
--disable-libssp \
--disable-libvtv \
--disable-libstdcxx \
--enable-languages=c,c++

make 
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h



