#!/bin/bash 

# The exec env -i.../bin/bash command in the .bash_profile file 
# replaces the running shell with a new one with a completely empty environment, 
# except for the HOME, TERM, and PS1 variables. 
# This ensures that no unwanted and potentially hazardous environment variables from the host system leak into the build environment:
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h                                       # turns off bash's hash function (the full path to execs)
umask 022                                    # file-creation mask
LFS=/mnt/lfs                                 # $LFS
LC_ALL=POSIX                                 # POSIX locale work as expected in the cross-compilation env
LFS_TGT=$(uname -m)-lfs-linux-gnu            # compatible machine descritption
PATH=/usr/bin                                # | PATH      
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi   # |    variable
PATH=$LFS/tools/bin:$PATH                    # for cross comp
CONFIG_SITE=$LFS/usr/share/config.site       # prevent: usage host files: configure scripts
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE   # visibility in sub-shells
EOF

# disable instantiation of /etc/bash.bashrc to the initialization of bash: 
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF

source ~/.bash_profile 



