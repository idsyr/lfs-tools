#!/bin/sh 

function select_lfs_build_target {
	cd $LFS/sources
	tar -xf ${1}*tar* --recursive-unlink
	cd ${1}*/
}
