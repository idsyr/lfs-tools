#!/bin/bash 
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=coreutils

select_lfs_build_target $LFS_TARGET

config_args=(
	--prefix=/usr 
	--host=$LFS_TGT 
	--build=$(build-aux/config.guess) 
	--enable-install-program=hostname  # for Perl test suite
	--enable-no-install-program=kill,uptime
)
./configure ${config_args[@]}

make -s
make -s DESTDIR=$LFS install

mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8


