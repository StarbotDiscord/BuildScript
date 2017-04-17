#!/bin/bash

source ../common/prep.sh
source ../../common/env.sh

#  _____       _   _                   ____   _____ 
# |  __ \     | | | |                 |___ \ | ____|
# | |__) _   _| |_| |__   ___  _ __     __) || |__  
# |  ___| | | | __| '_ \ / _ \| '_ \   |__ < |___ \ 
# | |   | |_| | |_| | | | (_) | | | |  ___) _ ___) |
# |_|    \__, |\__|_| |_|\___/|_| |_| |____(_|____/ 
#         __/ |                                     
#        |___/                                      

source ../../common/py35deps.sh

curl -k openssl-1.0.2k https://www.openssl.org/source/openssl-1.0.2k.tar.gz > openssl-1.0.2k.tar.gz
tar xf openssl-1.0.2k.tar.gz
cd openssl-1.0.2k
./Configure darwin64-x86_64-cc --prefix=$INSTALLDIR 
make depend
make $MAKEARGS
make install
cd ..

cp -r $INSTALLDIR/lib $HOME/lib
downloadAndCompile Python-3.6.1 https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
rm -rf $HOME/lib

source ../../common/updatessl.sh

$INSTALLDIR/bin/pip3 install discord.py pluginbase psutil pyparsing pyspeedtest tqdm

#  _      _ _      ____  _____  _    _  _____ 
# | |    (_| |    / __ \|  __ \| |  | |/ ____|
# | |     _| |__ | |  | | |__) | |  | | (___  
# | |    | | '_ \| |  | |  ___/| |  | |\___ \ 
# | |____| | |_) | |__| | |    | |__| |____) |
# |______|_|_.__/ \____/|_|     \____/|_____/ 

source ../../common/libopus.sh