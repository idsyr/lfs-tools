#!/bin/bash 

sudo -E mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} # creating dirs
for i in bin lib sbin; do
    sudo -E ln -sv usr/$i $LFS/$i # symbolic links in $LFS on dirs in $LFS/usr/
done

case $(uname -m) in
    x86_64) 
		sudo -E mkdir -pv $LFS/lib64 
	;; # if 64 -> +lib64
esac

sudo -E mkdir -pv $LFS/tools # for cross-comiler
