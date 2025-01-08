#!/bin/sh 

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# -s /bin/bash - this makes bash the default for user lfs
# -g lfs - adds user lfs to group lfs 
# -m - this creates a home directory for lfs
# -k /dev/null - this parametr prevents possible copting of files from skeleton directory (the defualt is /etc/skel) by changing input location to the special null device
# lfs - this is the name of the new user


# for switch to lfs from non-root user (required pswd):
passwd lfs 

# Grant lfs full access to all the directories under $LFS by making lfs the owner:
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64) chown -v lfs $LFS/lib64 ;;
esac

# Start the shell as a login shell with an environment similar to a real login:
su - lfs 

