export INSTALLDIR=$HOME/Starbot.framework
export PATH=$INSTALLDIR/bin:$PATH

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