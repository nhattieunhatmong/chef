#!/bin/bash
wget http://us.download.nvidia.com/tesla/396.44/nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb
sudo apt-key add /var/nvidia-diag-driver-local-repo-396.44/7fa2af80.pub
sudo dpkg -i nvidia-diag-driver-local-repo-ubuntu1604-396.44_1.0-1_amd64.deb
sudo apt-key add /var/nvidia-diag-driver-local-repo-396.44/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda-drivers --allow-unauthenticated
cd /usr/local/src/
wget https://github.com/ethereum-mining/ethminer/releases/download/v0.16.1/ethminer-0.16.1-linux-x86_64.tar.gz
tar -xf ethminer-0.16.1-linux-x86_64.tar.gz
bash -c 'cat <<EOT >>/lib/systemd/system/eth.service 
[Unit]
Description=eth
After=network.target
[Service]
ExecStart= /usr/local/src/bin/ethminer -U -P stratum://0x48e734140a3e85eefe8bbd19deeca87cf38ec722.w1810@us2.ethermine.org:4444
WatchdogSec=730
Restart=always
RestartSec=30
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable eth.service &&
service eth start

