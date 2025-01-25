#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

LFS_TARGET=glibc
select_lfs_build_target glibc

case $(uname -m) in
    i?86)
        ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) 
        ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
        ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

mkdir -p build && cd build

# ensure that the ldconfig and sln utillities are installed into /usr/bin/:
echo "rootsbindir=/usr/sbin" > configparms

config_args=(
	--prefix=/usr 
	--host=$LFS_TGT                    # | builid system configures itself to be
	--build=$(../scripts/config.guess) # | cross-compiled, using $LFS/tools/
	--enable-kernel=4.19               # support for and later Linux kernels
	--with-headers=$LFS/usr/include    # compile itself against the headers in DIR
	--disable-nscd                     # do not build the name service cache daemon which is no longer used
	libc_cv_slibdir=/usr/lib           # /usr/lib instead lib64
)

../configure ${config_args[@]}

make -s
make -s DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd


