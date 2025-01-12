#!/bin/sh 

# binutils contains:
#	linker
#	assembler
#	other tools for handling objects files

source $(dirname "$0")/common_funcs.sh

LFS_TARGET=binutils
select_lfs_taget

mkdir -p build && cd build

config_args=(
	--prefix=$LFS/tools             # prepare to install in =<dir>
	--with-sysroot=$LFS             # tell the build system to look libs in =<dir>
	--target=$LFS_TGT               # adjust binutil's build system for building cross linker
	--disable-nls                   # disable internationalization as i18n is not needed for temp tools
	--enable-gprofng=no             # disable build gprofng which          is not needed for temp tools
	--disable-werror                # prevents the build from stopping if warnings
	--enable-new-dtags              # runpath instead of rpath
	--enable-default-hash-style=gnu # only GNU-style hash table for shared libs
)

../configure "${config_args}"
make
make install


 
