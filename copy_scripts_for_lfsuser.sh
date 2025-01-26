#!/bin/bash 

sudo cp -v setting_up_environment.sh       /home/$LFSUSER/

sudo cp -v common_funcs.sh                 /home/$LFSUSER/

sudo cp -v install_cross.sh                /home/$LFSUSER/
sudo cp -v install_cross_binutils.sh       /home/$LFSUSER/
sudo cp -v install_cross_gcc.sh            /home/$LFSUSER/
sudo cp -v install_cross_linux_headers.sh  /home/$LFSUSER/
sudo cp -v install_cross_glibc.sh          /home/$LFSUSER/
sudo cp -v install_cross_libstd++.sh       /home/$LFSUSER/

sudo cp -v install_temptool.sh             /home/$LFSUSER/
sudo cp -v install_temptool_m4.sh          /home/$LFSUSER/
sudo cp -v install_temptool_ncurses.sh     /home/$LFSUSER/
sudo cp -v install_temptool_bash.sh        /home/$LFSUSER/
sudo cp -v install_temptool_coreutils.sh   /home/$LFSUSER/ 
sudo cp -v install_temptool_diffutils.sh   /home/$LFSUSER/
sudo cp -v install_temptool_file.sh        /home/$LFSUSER/
sudo cp -v install_temptool_findutils.sh   /home/$LFSUSER/
sudo cp -v install_temptool_gawk.sh        /home/$LFSUSER/
sudo cp -v install_temptool_grep.sh        /home/$LFSUSER/
sudo cp -v install_temptool_gzip.sh        /home/$LFSUSER/
sudo cp -v install_temptool_make.sh        /home/$LFSUSER/
sudo cp -v install_temptool_patch.sh       /home/$LFSUSER/
sudo cp -v install_temptool_sed.sh         /home/$LFSUSER/
sudo cp -v install_temptool_tar.sh         /home/$LFSUSER/
sudo cp -v install_temptool_xz.sh          /home/$LFSUSER/
sudo cp -v install_temptool_binutils.sh    /home/$LFSUSER/  # pass 2! required rm folder
sudo cp -v install_temptool_gcc.sh         /home/$LFSUSER/ 
