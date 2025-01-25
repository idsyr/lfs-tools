#!/bin/bash 

export LFSUSER=lfs

#./load_sources.sh 
./create_directory_layout.sh 
./add_lfs_user.sh 
./copy_scripts_for_lfsuser.sh 

# Start the shell as a login shell with an environment similar to a real login:
sudo su - $LFSUSER

