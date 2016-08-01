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
# sudo cp * /etc/openvpn
#  cd /etc/openvpn
# more server.conf
# port 1194
# proto udp
# dev tun
# ca ca.crt
# cert testserver.crt
# key testserver.key
# dh dh2048.pem
  
# server 10.8.0.0 255.255.255.0
# ifconfig-pool-persist ipp.txt

# push "redirect-gateway def1"
# push "dhcp-option DNS 8.8.8.8"
# keepalive 10 120
# comp-lzo
# max-clients 100
# persist-key
# persist-tun
# status openvpn-status.log
# verb 3
# 
# cat /etc/resolv.conf
# nameserver ipadresi
# sudo /etc/init.d/openvpn stop
# sudo /etc/init.d/openvpn start
# netstat -an | GREP 1194
# exit
# exit
# source vars
# ./build-key testclient
# more client.conf
# client
# dev tun
# proto udp
# remote serveradı ya da ip adresi 1194
# nobind
# resolv-retry infinite
# tls-client
# ca ca.crt
# cert testclient.crt
# key testclient. key
# ns-cert-type testserver
# cipher BF-CBC
# tls-cipher DHE-RSA-AES256-SHA
# tls-remote testserver
## tls-auth /opt/local/etc/openvpn/tls-auth.key 1
#remote-cert-tls testserver
# comp-lzo
# persist-key
# persist-tun
# mute-replay-warnings
# verb 3
# redirect-gateway def1
# mlock



  
  log openvpn.log
  comp.lzo
  push "redirect-gateway def1 bypass-dhcp"

#  push "route 10.6.11.1 255.255.255.0"
  
  push "dhcp option DOMAIN testserver.com"
  push "dhcp-option DNS 10.6.11.4"
  
  keepalive 1 3
  
  log openvpn.log
  comp.lzo
  push "redirect-gateway def1 bypass-dhcp"




sudo cd ..
source vars 
 
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



