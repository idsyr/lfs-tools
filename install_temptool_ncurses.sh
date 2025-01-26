#!/bin/bash 
source $(dirname "$0")/common_funcs.sh

select_lfs_build_target ncurses

mkdir build
pushd build
    ../configure
    make -C include
    make -C progs tic
popd

config_args=(
	--prefix=/usr 
	--host=$LFS_TGT 
	--build=$(./config.guess) 
	--mandir=/usr/share/man 
	--with-manpage-format=normal 
	--with-shared 
	--without-normal              # no static c libs 
	--with-cxx-shared             # no static c++ libs, shared
	--without-debug 
	--without-ada 
	--disable-stripping           # prevents using strip from host
)

./configure ${config_args[@]}


make -s
make -s DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
ln -sv libncursesw.so $LFS/usr/lib/libncurses.so   # used as a replacement
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i $LFS/usr/include/curses.h                   # bcse libcursesw 


