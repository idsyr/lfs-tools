#!/bin/sh 

# The exec env -i.../bin/bash command in the .bash_profile file replaces the running shell with a new one with a completely empty environment, except for the HOME, TERM, and PS1 variables. This ensures that no unwanted and potentially hazardous environment variables from the host system leak into the build environment
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h 
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
# set +h - turns off bash's hash function
# umask 022 - new files with 644 mode
# LFS=/mnt/lfs - $LFS
# LC_ALL=POSIX - controls the localization of certain programs
# LFS_TGT=$(uname -m)-lfs-linux-gnu - for cross compiler
# PATH=/usr/bin - std PATH variable
# if [ ! -L /bin ]; then PATH=/bin:$PATH; fi - if /bin is not a symbolic link, it must be added to the path variable
# PATH=$LFS/tools/bin:$PATH - by putting ahead of the std path, the cross-compiler is picked up by the shell immediately after its installlation
# CONFIG_SITE=$LFS/usr/share/config.site - prevent potential contamination from the host
# export - visible within any sub-shells

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
# disable instantiation of /etc/bash.bashrc to the initialization of bash 

cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF

