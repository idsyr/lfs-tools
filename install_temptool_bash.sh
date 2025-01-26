#!/bin/bash 
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=bash

select_lfs_build_target $LFS_TARGET

./configure \
--prefix=/usr \
--build=$(sh support/config.guess) \
--host=$LFS_TGT \
--without-bash-malloc \
bash_cv_strtold_broken=no

make -s
make -s DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh


