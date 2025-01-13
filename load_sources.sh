#!/bin/bash 

if [[ -z "$LFS" ]]; then
	echo "ERROR: LFS: is not set."
	exit
fi

sudo -E mkdir -v $LFS/sources
sudo -E chmod -v a+wt $LFS/sources     # only the owner of a file can delete the file within a sticky directory.
sudo -E wget --input-file=wget-list-lfs-sysv --continue --directory-prefix=$LFS/sources
sudo -E chown root:root $LFS/sources/* # otherwise files will be left owned by an unnamed UID in the final LFS system

exit

# FIXME: sudo timeout
