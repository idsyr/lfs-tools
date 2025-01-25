#!/bin/bash
source $(dirname "$0")/common_funcs.sh

LFS_TARGET=gcc
select_lfs_build_target gcc

mkdir -p build && cd build

config_args=(
	--host=$LFS_TGT 
	--build=$(../config.guess) 
	--prefix=/usr 
	--disable-multilib 
	--disable-nls 
	--disable-libstdcxx-pch 
	--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0
)

../libstdc++-v3/configure ${config_args[@]}

make -s
make -s DESTDIR=$LFS install

# libtool archieve files harmful for cross-compilation
rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la


