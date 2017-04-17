downloadAndCompile lbzip2-2.5 http://archive.lbzip2.org/lbzip2-2.5.tar.gz
downloadAndCompile gperf-3.1 http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
downloadAndCompile libiconv-1.15 https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz "--with-gperf=$INSTALLDIR"
downloadAndCompile expat-2.2.0 http://starbutterfly.sydneyerickson.me/expat-2.2.0.tar.bz2 "--with-lbzip2=$INSTALLDIR"
downloadAndCompile ncurses-6.0 https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz "--with-shared"
downloadAndCompile gettext-0.19.8.1 https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz "--disable-static --with-expat=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-ncurses=$INSTALLDIR"
downloadAndCompile xz-5.2.3 http://tukaani.org/xz/xz-5.2.3.tar.gz "--with-lbzip2=$INSTALLDIR --with-libiconv=$INSTALLDIR --with-gettext=$INSTALLDIR"
downloadAndCompile zlib-1.2.11 http://zlib.net/zlib-1.2.11.tar.gz

curl http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz > bzip2-1.0.6.tar.gz
tar xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make $MAKEARGS
make install PREFIX=$INSTALLDIR
cd ..

downloadAndCompile libedit-20160903-3.1 http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz "--with-ncurses=$INSTALLDIR"
downloadAndCompile sqlite-autoconf-3170000 http://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz "--with-libedit=$INSTALLDIR --with-ncurses=$INSTALLDIR"