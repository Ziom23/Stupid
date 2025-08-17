#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libxcb-xinerama0 -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=7dcb36ae1fec245a9307e8bd9493bb437439ebd6d94ad2b6b4&filename=stupid-qt-linux.tar.gz" -O stupid-qt-linux.tar.gz

mkdir $HOME/Desktop/Stupid

tar -xzvf stupid-qt-linux.tar.gz --directory $HOME/Desktop/Stupid

mkdir $HOME/.stupid

cat << EOF > $HOME/.stupid/stupid.conf
rpcuser=rpc_stupid
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Stupid/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./stupid-qt
EOF

chmod +x $HOME/Desktop/Stupid/start_wallet.sh

cat << EOF > $HOME/Desktop/Stupid/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./stupid-cli generatetoaddress 1 \$(./stupid-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Stupid/mine.sh
    
exec $HOME/Desktop/Stupid/stupid-qt &

sleep 15

exec $HOME/Desktop/Stupid/stupid-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/Stupid/

clear

exec $HOME/Desktop/Stupid/mine.sh