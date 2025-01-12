#!/bin/sh 

function select_lfs_target {
	cd $LFS/sources
	tar -xf $LFS_TARGET*tar* --recursive-unlink
	cd $LFS_TARGET*/
}
