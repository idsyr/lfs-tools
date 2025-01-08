#!/bin/sh 

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} # creating dirs
for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i # symbolic links in $LFS on dirs in usr/
done

case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;; # if 64 -> +lib64
esac

mkdir -pv $LFS/tools # for cross-comiler
