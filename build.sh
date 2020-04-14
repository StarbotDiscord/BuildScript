#!/bin/bash

rm -rf lbzip2* gperf* libiconv* expat* gettext* ncurses* xz* zlib* openssl* bzip2* libedit* sqlite* Python* pkg-config* opus*

export INSTALLDIR=$HOME/Starbot.framework
export PATH=$INSTALLDIR/bin:$PATH

set -e

# $1 - Project name
# $2 - Project URL
# $3 - Additional config args
function downloadAndCompile {
    echo $1
    curl -L $2 > $1.tar.gz
    tar -xf $1.tar.gz
    cd $1
    ./configure --prefix=$INSTALLDIR $3 >> build.log 2>&1
    make $MAKEARGS >> build.log 2>&1
    make install >> build.log 2>&1
    cd ..
}

#  _____       _   _
# |  __ \     | | | |
# | |__) _   _| |_| |__   ___  _ __
# |  ___| | | | __| '_ \ / _ \| '_ \
# | |   | |_| | |_| | | | (_) | | | |
# |_|    \__, |\__|_| |_|\___/|_| |_|
#         __/ |                                     
#        |___/                                      

downloadAndCompile lbzip2-2.5 https://fossies.org/linux/privat/lbzip2-2.5.tar.gz
downloadAndCompile gperf-3.1 http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
downloadAndCompile libiconv-1.16 https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz "--with-gperf=$INSTALLDIR"
downloadAndCompile expat-2.2.9 https://github.com/libexpat/libexpat/releases/download/R_2_2_9/expat-2.2.9.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.2 https://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz "--with-shared"
downloadAndCompile gettext-0.20.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz "--disable-static --with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.5 https://fossies.org/linux/misc/xz-5.2.5.tar.xz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz
unamestr=$(uname)

curl -k openssl-1.0.2s https://www.openssl.org/source/openssl-1.1.1d.tar.gz > openssl-1.1.1d.tar.gz
tar xf openssl-1.1.1d.tar.gz
cd openssl-1.1.1d
if [[ "$unamestr" == 'Darwin' ]]; then
   ./Configure darwin64-x86_64-cc --prefix=$INSTALLDIR  >> build.log 2>&1
elif [[ "$unamestr" == 'Linux' ]]; then

if [[ "$CC" == 'clang' ]]; then
   ./Configure linux-x86_64-clang --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib >> build.log 2>&1
else
   ./Configure linux-generic64 --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib >> build.log 2>&1
fi
   ./config --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib >> build.log 2>&1
fi
make depend >> build.log 2>&1
make $MAKEARGS >> build.log 2>&1
make install >> build.log 2>&1
cd ..

curl https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz > bzip2-1.0.8.tar.gz
tar xf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8
make $MAKEARGS >> build.log 2>&1
make install PREFIX=$INSTALLDIR >> build.log 2>&1
cd ..

downloadAndCompile libedit-20191231-3.1 http://thrysoee.dk/editline/libedit-20191231-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3310100 https://www.sqlite.org/2020/sqlite-autoconf-3310100.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"
cp -r $INSTALLDIR/lib $HOME/lib
downloadAndCompile Python-3.8.2 https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
rm -rf $HOME/lib

if [[ "$unamestr" == 'Darwin' ]]; then
    ./updatessl.sh >> build.log 2>&1
fi

$INSTALLDIR/bin/pip3 install discord.py pluginbase psutil pyparsing pyspeedtest tqdm >> build.log 2>&1
