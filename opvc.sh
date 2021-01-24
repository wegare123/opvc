#!/bin/bash
#opvc (Wegare)
user2="$(cat /root/akun/pass-opvc.txt | awk 'NR==1')" 
host2="$(cat /root/akun/opvc.txt | grep -i host | cut -d= -f2 | head -n1)"
port2="$(cat /root/akun/opvc.txt | grep -i port | cut -d= -f2 | head -n1)" 
pass2="$(cat /root/akun/pass-opvc.txt | awk 'NR==2')" 
openvpn2="$(cat /root/akun/opvc.txt | grep -i direkopvpn | cut -d= -f2)" 
json2="$(cat /root/akun/opvc.txt | grep -i direkjson | cut -d= -f2)" 
clear
echo "Inject openvpn cloak by wegare"
echo "1. Sett Profile"
echo "2. Start Inject"
echo "3. Stop Inject"
echo "4. Enable auto booting & auto rekonek"
echo "5. Disable auto booting & auto rekonek"
echo "e. exit"
read -p "(default tools: 2) : " tools
[ -z "${tools}" ] && tools="2"
if [ "$tools" = "1" ]; then
echo "Masukkan host/ip" 
read -p "default host/ip: $host2 : " host
[ -z "${host}" ] && host="$host2"

echo "Masukkan port cloak" 
read -p "default port cloak: $port2 : " port
[ -z "${port}" ] && port="$port2"

echo "Masukkan user" 
read -p "default user: $user2 : " user
[ -z "${user}" ] && user="$user2"

echo "Masukkan pass" 
read -p "default pass: $pass2 : " pass
[ -z "${pass}" ] && pass="$pass2"
echo ""
echo "edit config ovpn" 
echo "tambahkan /root/akun/pass-opvc.txt di auth-user-pass" 
echo "contoh : auth-user-pass /root/akun/pass-opvc.txt" 
echo "untuk bug silahkan edit config json di bagian ServerName"
echo 'contoh : "ServerName":"isi bug disini",'
echo "lalu masukkan 2 config kedalam direktori openwrt"
echo ""
echo "Masukkan direktori config ovpn : " 
read -p "default direktori config ovpn: $openvpn2 : " openvpn
[ -z "${openvpn}" ] && openvpn="$openvpn2"

echo "Masukkan direktori config json : " 
read -p "default direktori config json: $json2 : " json
[ -z "${json}" ] && json="$json2"

echo "host=$host
port=$port
direkopvpn=$openvpn
direkjson=$json" > /root/akun/opvc.txt
echo "$user
$pass" > /root/akun/pass-opvc.txt
echo "Sett Profile Sukses"
sleep 2
clear
/usr/bin/opvc
elif [ "${tools}" = "2" ]; then
host="$(cat /root/akun/opvc.txt | grep -i host | cut -d= -f2 | head -n1)" 
port="$(cat /root/akun/opvc.txt | grep -i port | cut -d= -f2 | head -n1)" 
json="$(cat /root/akun/opvc.txt | grep -i direkjson | cut -d= -f2 | head -n1)" 
opvpn="$(cat /root/akun/opvc.txt | grep -i direkopvpn | cut -d= -f2 | head -n1)" 
ck-client -u -c $json -s $host -p $port &
sleep 3
openvpn $opvpn &
elif [ "${tools}" = "3" ]; then
killall -q openvpn ck-client dnsmasq 
/etc/init.d/dnsmasq start > /dev/null
echo "Stop Suksess"
sleep 2
clear
/usr/bin/opvc
elif [ "${tools}" = "4" ]; then
cat <<EOF>> /etc/crontabs/root

# BEGIN AUTOREKONEKOPVC
*/1 * * * *  autorekonek-opvc
# END AUTOREKONEKOPVC
EOF
sed -i 's/exit 0/ /g' /etc/rc.local
/etc/init.d/cron restart
echo "Enable Suksess"
sleep 2
clear
/usr/bin/opvc
elif [ "${tools}" = "5" ]; then
sed -i "/^# BEGIN AUTOREKONEKOPVC/,/^# END AUTOREKONEKOPVC/d" /etc/crontabs/root > /dev/null
/etc/init.d/cron restart
echo "Disable Suksess"
sleep 2
clear
/usr/bin/opvc
elif [ "${tools}" = "e" ]; then
clear
exit
else 
echo -e "$tools: invalid selection."
exit
fi