set -e

wget ftp://ftp.cwru.edu/pub/bash/readline-7.0.tar.gz
tar xf readline-7.0.tar.gz
mv readline-7.0 readline
cd readline
./configure --prefix=$HOME/Starbot.framework
make
make install