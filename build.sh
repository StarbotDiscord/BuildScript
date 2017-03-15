# Python 3.5
# ├ XZ
# │  ├ lbzip2
# │  ├ libiconv
# │  │ └ gperf
# │  └ gettext
# │    ├ expat
# │    │ └ lbzip2    (installed before)
# │    ├ libiconv    (installed before)
# │    └ ncurses
# ├ zlib
# │ └ XZ             (see above)
# ├ openssl
# │ └ zlib           (see above)
# ├ bzip2
# ├ gettext          (installed before)
# ├ libedit
# │ └ ncurses        (installed before)
# ├ ncurses          (installed before)
# └ sqlite3
#   ├ libedit        (installed before)
#   └ ncurses        (installed before)


rm -rf lbzip2* gperf* libiconv* expat* gettext* ncurses* xz* zlib* openssl* bzip2* libedit* sqlite3*

export INSTALLDIR=$HOME/Starbot.framework

set -e

# $1 - Project name
# $2 - Project URL
# $3 - Additional config args
function downloadAndCompile {
    curl $2 > $1.tar.gz
    tar xf $1.tar.gz
    cd $1
    ./configure --prefix=$INSTALLDIR $3
    make
    make install
    cd ..
}

downloadAndCompile lbzip2-2.5 http://archive.lbzip2.org/lbzip2-2.5.tar.gz
downloadAndCompile gperf-3.1 http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
downloadAndCompile libiconv-1.15 https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz "--with-gperf=$INSTALLDIR"
downloadAndCompile expat-2.2.0 https://sydneyerickson.me/mirror/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.0 https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
downloadAndCompile gettext-0.19.8.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz "--with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.3 http://tukaani.org/xz/xz-5.2.3.tar.gz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz
downloadAndCompile openssl-1.0.2k https://www.openssl.org/source/openssl-1.0.2k.tar.gz "darwin64-x86_64-cc --with-zlib=$INSTALLDIR"
downloadAndCompile bzip2-1.0.6 http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz
downloadAndCompile libedit-20160903-3.1 http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3170000 http://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"