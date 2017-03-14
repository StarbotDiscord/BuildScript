set -e

curl https://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz > readline.tar.gz
tar xf readline.tar.gz
mv readline-7.0 readline
cd readline
./configure --prefix=$HOME/Starbot.framework
make
make install