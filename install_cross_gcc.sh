#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

LFS_TARGET=gcc
select_lfs_build_target ${LFS_TARGET}
 
tar -xf ../mpfr*tar* && mv mpfr*/ mpfr/ # Unpack each package into the GCC source directory 
tar -xf ../gmp*tar*  && mv gmp*/  gmp/  # and rename the resulting directories so
tar -xf ../mpc*tar*  && mv mpc*/  mpc/  # the GCC build procedures will automatically use them

# set default directory name for 64-bit libs to "lib"
case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
esac

mkdir -p build && cd build

config_args=(
	--target=$LFS_TGT 
	--prefix=$LFS/tools 
	--with-glibc-version=2.40 
	--with-sysroot=$LFS  
	--with-newlib        # This prevents the compiling of any code that requires libc support
	--without-headers    # For complete cross-compiler GCC requires standard headers compatible with the target system. will not be needed.
	--enable-default-pie # | hardening 
	--enable-default-ssp # | security
	--disable-nls 
	--disable-shared     # shared libs require Glibc, which is not yet installed
	--disable-multilib     # | 
	--disable-threads      # | 
	--disable-libatomic    # | 
	--disable-libgomp      # | 
	--disable-libquadmath  # | These features may fail to complie when building a cross-compiler
	--disable-libssp       # | and are not necessary for the task of cross-compiling the temp libc
	--disable-libvtv       # | 
	--disable-libstdcxx    # | 
	--enable-languages=c,c++ # ONLY languages needed now
)


../configure ${config_args[@]}

make -s 
make -s install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h



