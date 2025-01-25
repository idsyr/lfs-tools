#!/bin/bash 

sudo groupadd $LFSUSER
sudo useradd -s /bin/bash -g lfs -m -k /dev/null $LFSUSER

# -s /bin/bash - this makes bash the default for user lfs
# -g lfs - adds user lfs to group lfs 
# -m - this creates a home directory for lfs
# -k /dev/null - this parametr prevents possible copting of files from skeleton directory (the defualt is /etc/skel) by changing input location to the special null device
# lfs - this is the name of the new user


# for switch to lfs from non-root user (required pswd):
echo 0000 | sudo passwd $LFSUSER --stdin 

# Grant lfs full access to all the directories under $LFS by making lfs the owner:
sudo -E chown -v $LFSUSER $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64)
		sudo -E chown -v lfs $LFS/lib64 
	;;
esac






