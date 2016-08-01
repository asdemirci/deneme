sudo apt-get install openvpn easy-rsa
sudo mkdir /etc/openvpn/easy-rsa
sudo cp -R /usr/share/openvpn/easy-rsa/* /etc/openvpn/easy-rsa
sudo cd /etc/openvpn/easy-rsa
sudo vim vars
source vars
./clean-all
./build-ca
./build-key-server testserver
./build-dh



