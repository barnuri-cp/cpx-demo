#!/bin/bash
set -e 

mkdir -p /home/ubuntu/attacker
mkdir -p /home/ubuntu/attacker/attackWeb
mkdir -p /home/ubuntu/attacker/javaTmp
echo "" > /home/ubuntu/attacker/nohup.out
echo "" > /home/ubuntu/attacker/output.log
chmod -R 777 /home/ubuntu/attacker/output.log
chmod -R 777 /home/ubuntu/attacker/nohup.out
chmod -R 777 /home/ubuntu/attacker
chmod -R 777 /home/ubuntu/attacker/attackWeb
chmod -R 777 /home/ubuntu/attacker/javaTmp

ln -s /home/ubuntu/attacker/nohup.out /home/ubuntu/attacker/attackWeb/nohup.txt
ln -s /home/ubuntu/attacker/output.log /home/ubuntu/attacker/attackWeb/output.txt
chmod -R 777 /home/ubuntu/attacker/attackWeb/nohup.txt
chmod -R 777 /home/ubuntu/attacker/attackWeb/output.txt

sudo apt update -y
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo rm -rf /etc/nginx/sites-available/default
sudo ln -s /home/ubuntu/attacker/nginx.conf /etc/nginx/sites-available/default
sudo apt-get install -y libnginx-mod-http-lua
sudo systemctl enable nginx
sudo systemctl reload nginx

sudo apt install default-jre -y
./runAttack.sh &

echo "make sure you open ports 80 443 8888 9999 1393"