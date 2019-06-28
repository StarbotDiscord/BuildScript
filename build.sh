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
    ./configure --prefix=$INSTALLDIR $3 &>> build.log
    make $MAKEARGS &>> build.log
    make install &>> build.log
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
downloadAndCompile expat-2.2.0 http://oe-lite.org/mirror/expat/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.1 https://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz "--with-shared"
downloadAndCompile gettext-0.20.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz "--disable-static --with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.4 https://fossies.org/linux/misc/xz-5.2.4.tar.gz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz
unamestr=$(uname)

curl -k openssl-1.0.2s https://www.openssl.org/source/openssl-1.0.2s.tar.gz > openssl-1.0.2s.tar.gz
tar xf openssl-1.0.2s.tar.gz
cd openssl-1.0.2s
if [[ "$unamestr" == 'Darwin' ]]; then
   ./Configure darwin64-x86_64-cc --prefix=$INSTALLDIR  &>> build.log
elif [[ "$unamestr" == 'Linux' ]]; then

if [[ "$CC" == 'clang' ]]; then
   ./Configure linux-x86_64-clang --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib &>> build.log
else
   ./Configure linux-generic64 --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib &>> build.log
fi
   ./config --prefix=$INSTALLDIR -fPIC no-gost no-shared no-zlib &>> build.log
fi
make depend &>> build.log
make $MAKEARGS &>> build.log
make install &>> build.log
cd ..

curl https://sourceware.org/pub/bzip2/bzip2-1.0.7.tar.gz > bzip2-1.0.7.tar.gz
tar xf bzip2-1.0.7.tar.gz
cd bzip2-1.0.7
make $MAKEARGS &>> build.log
make install PREFIX=$INSTALLDIR &>> build.log
cd ..

downloadAndCompile libedit-20190324-3.1 http://thrysoee.dk/editline/libedit-20190324-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3280000 https://sqlite.org/2019/sqlite-autoconf-3280000.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"
cp -r $INSTALLDIR/lib $HOME/lib
downloadAndCompile Python-3.7.3 https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
rm -rf $HOME/lib

if [[ "$unamestr" == 'Darwin' ]]; then
    ./updatessl.sh &>> build.log
fi

$INSTALLDIR/bin/pip3 install discord.py pluginbase psutil pyparsing pyspeedtest tqdm &>> build.log
