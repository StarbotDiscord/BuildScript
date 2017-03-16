# Starbot
# ├ Python 3.5
# │ ├ XZ
# │ │ ├ lbzip2
# │ │ ├ libiconv
# │ │ │ └ gperf
# │ │ └ gettext
# │ │   ├ expat
# │ │   │ └ lbzip2           (installed before)
# │ │   ├ libiconv           (installed before)
# │ │   └ ncurses
# │ ├ zlib
# │ │ └ XZ                   (installed before)
# │ │   ├ lbzip2             (installed before)
# │ │   ├ libiconv           (installed before)
# │ │   │ └ gperf            (installed before)
# │ │   └ gettext            (installed before)
# │ │     ├ expat            (installed before)
# │ │     │ └ lbzip2         (installed before)
# │ │     ├ libiconv         (installed before)
# │ │     └ ncurses          (installed before)
# │ ├ openssl
# │ │ └ zlib                 (installed before)
# │ │   └ XZ                 (installed before)
# │ ├ bzip2
# │ ├ gettext                (installed before)
# │ │ ├ expat                (installed before)
# │ │ │ └ lbzip2             (installed before)
# │ │ ├ libiconv             (installed before)
# │ │ └ ncurses              (installed before)
# │ ├ libedit
# │ │ └ ncurses              (installed before)
# │ ├ ncurses                (installed before)
# │ └ sqlite3
# │   ├ libedit              (installed before)
# │   │ └ ncurses            (installed before)
# │   └ ncurses              (installed before)
# ├ libopus
# │ └ pkgconfig
# │   └ libiconv             (installed before)
# │     └ gperf              (installed before)
# └ PostreSQL 9.6
#   ├ lbzip2                 (installed before)
#   ├ openssl                (installed before)
#   │ └ zlib                 (installed before)
#   │   └ XZ                 (installed before)
#   ├ bison
#   │ ├ perl 5
#   │ │ ├ lbzip2             (installed before)
#   │ │ └ gdbm
#   │ │   ├ gettext          (installed before)
#   │ │   │ ├ expat          (installed before)
#   │ │   │ │ └ lbzip2       (installed before)
#   │ │   │ ├ libiconv       (installed before)
#   │ │   │ └ ncurses        (installed before)
#   │ │   └ gettext          (installed before)
#   │ │     └ ncurses        (installed before)
#   │ ├ gettext              (installed before)
#   │ ├ XZ                   (installed before)
#   │ │ ├ lbzip2             (installed before)
#   │ │ ├ libiconv           (installed before)
#   │ │ │ └ gperf            (installed before)
#   │ │ └ gettext            (installed before)
#   │ │   ├ expat            (installed before)
#   │ │   │ └ lbzip2         (installed before)
#   │ │   ├ libiconv         (installed before)
#   │ │   └ ncurses          (installed before)
#   │ └ m4
#   │   └ lbzip2             (installed before)
#   ├ libxml2
#   │ ├ libiconv             (installed before)
#   │ ├ XZ                   (installed before)
#   │ └ zlib                 (installed before)
#   │   └ XZ                 (installed before)
#   ├ libxslt
#   │ ├ libiconv             (installed before)
#   │ ├ libxml2              (installed before)
#   │ └ zlib                 (installed before)
#   ├ readline
#   │ └ ncurses              (installed before)
#   └ zlib                   (installed before)
#     └ XZ                   (installed before)


rm -rf lbzip2* gperf* libiconv* expat* gettext* ncurses* xz* zlib* openssl* bzip2* libedit* sqlite* Python* pkg-config* opus*

export INSTALLDIR=$HOME/Starbot.framework
export PATH=$INSTALLDIR/bin:$PATH

set -e

# $1 - Project name
# $2 - Project URL
# $3 - Additional config args
function downloadAndCompile {
    curl $2 > $1.tar.gz
    tar xf $1.tar.gz
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
downloadAndCompile expat-2.2.0 https://sydneyerickson.me/mirror/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.0 https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
downloadAndCompile gettext-0.19.8.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz "--with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.3 http://tukaani.org/xz/xz-5.2.3.tar.gz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   downloadAndCompile openssl-1.0.2k https://www.openssl.org/source/openssl-1.0.2k.tar.gz "darwin64-x86_64-cc"
elif [[ "$unamestr" == 'Linux' ]]; then
   downloadAndCompile openssl-1.0.2k https://www.openssl.org/source/openssl-1.0.2k.tar.gz "linux-x86_64-cc"
fi

curl http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz > bzip2-1.0.6.tar.gz
tar xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make $MAKEARGS
make install PREFIX=$INSTALLDIR
cd ..

downloadAndCompile libedit-20160903-3.1 http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3170000 http://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"
cp -r $INSTALLDIR/lib $HOME/lib
downloadAndCompile Python-3.5.3 https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz
rm -rf $HOME/lib
$INSTALLDIR/bin/pip3 install pluginbase psutil gitpython pyparsing

#  _      _ _      ____  _____  _    _  _____ 
# | |    (_| |    / __ \|  __ \| |  | |/ ____|
# | |     _| |__ | |  | | |__) | |  | | (___  
# | |    | | '_ \| |  | |  ___/| |  | |\___ \ 
# | |____| | |_) | |__| | |    | |__| |____) |
# |______|_|_.__/ \____/|_|     \____/|_____/ 

downloadAndCompile pkg-config-0.29.1 https://pkg-config.freedesktop.org/releases/pkg-config-0.29.1.tar.gz "--with-iconv=$INSTALLDIR --with-internal-glib"
downloadAndCompile opus-1.1.4 http://downloads.xiph.org/releases/opus/opus-1.1.4.tar.gz