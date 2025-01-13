#!/bin/bash 

sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# -s /bin/bash - this makes bash the default for user lfs
# -g lfs - adds user lfs to group lfs 
# -m - this creates a home directory for lfs
# -k /dev/null - this parametr prevents possible copting of files from skeleton directory (the defualt is /etc/skel) by changing input location to the special null device
# lfs - this is the name of the new user


# for switch to lfs from non-root user (required pswd):
echo 0000 | sudo passwd lfs --stdin 

# Grant lfs full access to all the directories under $LFS by making lfs the owner:
sudo -E chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64)
		sudo -E chown -v lfs $LFS/lib64 
	;;
esac

sudo cp -v setting_up_environment.sh /home/lfs/

sudo cp -v common_funcs.sh /home/lfs/
sudo cp -v install_cross_binutils.sh /home/lfs/


# Start the shell as a login shell with an environment similar to a real login:
sudo su - lfs






