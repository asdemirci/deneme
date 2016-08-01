sudo apt-get install openvpn easy-rsa
sudo mkdir /etc/openvpn/easy-rsa
sudo cp -R /usr/share/openvpn/easy-rsa/* /etc/openvpn/easy-rsa
sudo cd /etc/openvpn/easy-rsa
sudo vim vars
source vars
./clean-all
./build-ca
./build-key-server testserver
#openvpn --genkey --secret ta.key
source vars
./clean-all
./build-dh
sudo cd keys
sudo cp testserver.crt testserver.key ca.crt dh2048.pem /etc/openvpn
# sudo scp testserver.crt testserver.key ca.crt dh2048.pem ta.key username@ipadresi:/home/username
# ssh username@ipadresi
# sudo apt-get install openvpn
# 

sudo cd ..
source vars 
./build-key testclient
sudo cd ..
sudo touch server.conf
sudo vim server.conf
  ca ca.crt
  cert testserver.crt
  key testserver.key
  dh dh2048.pem
  
  server 10.8.0.0 255.255.255.0
  push "route 10.6.11.1 255.255.255.0"
  
  push "dhcp option DOMAIN testserver.com"
  push "dhcp-option DNS 10.6.11.4"
  
  keepalive 1 3
  
  log openvpn.log
  comp.lzo
  push "redirect-gateway def1 bypass-dhcp"



