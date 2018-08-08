sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git 
sudo sysctl vm.nr_hugepages=128 
cd /usr/local/src/
sudo git clone https://github.com/JayDDee/cpuminer-opt
cd cpuminer-opt
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/week0908/repool.sh
chmod +x repool.sh
./autogen.sh &&
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl
make
bash -c 'cat <<EOT >>/lib/systemd/system/1tieu1mong.service 
[Unit]
Description=1tieu1mong
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt/repool.sh
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
service 1tieu1mong start
