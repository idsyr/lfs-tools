#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

LFS_TARGET=linux
select_lfs_build_target ${LFS_TARGET}

make -s mrproper
make -s headers

# make_install requires rsync
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr


