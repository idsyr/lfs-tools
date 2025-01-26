#!/bin/bash 
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=gzip

select_lfs_build_target $LFS_TARGET

./configure --prefix=/usr --host=$LFS_TGT
make -s
make -s DESTDIR=$LFS install


