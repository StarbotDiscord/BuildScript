#!/bin/bash

rm -rf lbzip2* gperf* libiconv* expat* gettext* ncurses* xz* zlib* openssl* bzip2* libedit* sqlite* Python* pkg-config* opus*

export INSTALLDIR=$HOME/Starbot.framework
export PATH=$INSTALLDIR/bin:$PATH

set -e

# $1 - Project name
# $2 - Project URL
# $3 - Additional config args
function downloadAndCompile {
    curl $2 > $1.tar.gz
    tar -xf $1.tar.gz
    cd $1
    ./configure --prefix=$INSTALLDIR $3
    make $MAKEARGS
    make install
    cd ..
}

#  _____       _   _                   ____   _____ 
# |  __ \     | | | |                 |___ \ | ____|
# | |__) _   _| |_| |__   ___  _ __     __) || |__  
# |  ___| | | | __| '_ \ / _ \| '_ \   |__ < |___ \ 
# | |   | |_| | |_| | | | (_) | | | |  ___) _ ___) |
# |_|    \__, |\__|_| |_|\___/|_| |_| |____(_|____/ 
#         __/ |                                     
#        |___/                                      

downloadAndCompile lbzip2-2.5 http://archive.lbzip2.org/lbzip2-2.5.tar.gz
downloadAndCompile gperf-3.1 http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
downloadAndCompile libiconv-1.15 https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz "--with-gperf=$INSTALLDIR"
downloadAndCompile expat-2.2.0 http://oe-lite.org/mirror/expat/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.0 https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz "--with-shared"
downloadAndCompile gettext-0.19.8.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz "--disable-static --with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.3 https://fossies.org/linux/misc/xz-5.2.3.tar.gz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz
unamestr=$(uname)

curl -k openssl-1.0.2m https://www.openssl.org/source/openssl-1.0.2m.tar.gz > openssl-1.0.2m.tar.gz
tar xf openssl-1.0.2m.tar.gz
cd openssl-1.0.2m
if [[ "$unamestr" == 'Darwin' ]]; then
   ./Configure darwin64-x86_64-cc --prefix=$INSTALLDIR 
elif [[ "$unamestr" == 'Linux' ]]; then

if [[ "$CC" == 'clang' ]]; then
   ./Configure linux-x86_64-clang --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib
else
   ./Configure linux-generic64 --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib
fi
   ./config --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib
fi
make depend
make $MAKEARGS
make install
cd ..

curl http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz > bzip2-1.0.6.tar.gz
tar xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make $MAKEARGS
make install PREFIX=$INSTALLDIR
cd ..

downloadAndCompile libedit-20170329-3.1 http://thrysoee.dk/editline/libedit-20170329-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3210000 http://www.sqlite.org/2017/sqlite-autoconf-3210000.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"
cp -r $INSTALLDIR/lib $HOME/lib
downloadAndCompile Python-3.6.3 https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
rm -rf $HOME/lib

if [[ "$unamestr" == 'Darwin' ]]; then
    ./updatessl.sh
fi

$INSTALLDIR/bin/pip3 install discord.py pluginbase psutil pyparsing pyspeedtest tqdm
