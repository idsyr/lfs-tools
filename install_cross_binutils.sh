cd $LFS/sources
LFS_TARGET=binutils
tar -xf $LFS_TARGET*tar*
cd $LFS_TARGET*/

mkdir build
cd build

../configure \
# install in tools dir
--prefix=$LFS/tools \
# look the target system libs in $LFS
--with-sysroot=$LFS \
# adjust binutil's build system for building cross linker
--target=$LFS_TGT \
# disable internationalization as i18n is not needed for temp tools
--disable-nls \
# disable profiler
--enable-gprofng=no \
# prevent the build from stopping on warnings
--disable-werror \
# runpath instead of rpath
--enable-new-dtags \
# only one hash table for shared libs
--enable-default-hash-style=gnu

make
make install
