#!/bin/sh 
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources     # only the owner of a file can delete the file within a sticky directory.
chown root:root $LFS/sources/* # otherwise files will be left owned by an unnamed UID in the final LFS system
wget --input-file=wget-list-lfs-sysv --continue --directory-prefix=$LFS/sources

