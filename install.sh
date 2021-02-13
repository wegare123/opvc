#!/bin/bash
#opvc (Wegare)
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvc/main/opvc.sh" -O /usr/bin/opvc
wget --no-check-certificate "https://github.com/wegare123/opvc/blob/main/ck-client?raw=true" -O /usr/bin/ck-client
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/opvc/main/autorekonek-opvc.sh" -O /usr/bin/autorekonek-opvc
opkg update && opkg install lsof && opkg install openvpn-openssl fping
chmod +x /usr/bin/opvc
chmod +x /usr/bin/ck-client
chmod +x /usr/bin/autorekonek-opvc
rm -r ~/install.sh
mkdir -p ~/akun/
touch ~/akun/opvc.txt
sleep 2
echo "install selesai"
echo "untuk memulai tools silahkan jalankan perintah 'opvc'"

				