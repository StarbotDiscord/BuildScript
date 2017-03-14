# Python 3.5
# |_ XZ
#    |_ lbzip2
#    |_ libiconv
#    |  |_ gperf
#    |_ gettext
#       |_ expat
#       |  |_ lbzip2 (installed before)
#       |_ libiconv (installed before)
#       |_ ncurses


rm -rf lbzip2*
rm -rf gperf*
rm -rf libiconv*
rm -rf expat*
rm -rf gettest*
rm -rf ncurses*

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
}

downloadAndCompile lbzip2-2.5 http://archive.lbzip2.org/lbzip2-2.5.tar.gz
downloadAndCompile gperf-3.1 http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
downloadAndCompile libiconv-1.15 https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz "--with-gperf=$INSTALLDIR"
downloadAndCompile expat-2.2.0 https://sydneyerickson.me/mirror/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile gettest-0.19.8.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz "--with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile ncurses-6.0 https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
downloadAndCompile xz-5.3.2 http://tukaani.org/xz/xz-5.2.3.tar.gz