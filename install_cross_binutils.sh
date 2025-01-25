#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

# binutils contains:
# - linker
# - assembler
# - other tools for handling objects files

select_lfs_build_target binutils
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

../configure ${config_args[@]}
make -s
make -s install


 
