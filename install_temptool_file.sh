#!/bin/bash
source $(dirname "$0")/common_funcs.sh
LFS_TARGET=file
select_lfs_build_target $LFS_TARGET

# The file command on the build host needs to be the same version as the one we are building in order to create the signature file.
mkdir build
pushd build
    ../configure \
    --disable-bzlib \
    --disable-libseccomp \
    --disable-xzlib \
    --disable-zlib # prevent using from host this pkgs
    make
popd

./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

make -s FILE_COMPILE=$(pwd)/build/src/file
make -s DESTDIR=$LFS install
# harmful for cross
rm -v $LFS/usr/lib/libmagic.la


