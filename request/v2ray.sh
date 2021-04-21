#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;32m" [3]="\033[1;36m" [4]="\033[1;31m" )
barra="\033[0m\e[34m======================================================\033[1;37m"
SCPdir="/etc/newadm" && [[ ! -d ${SCPdir} ]] && exit 1
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
SCPidioma="${SCPdir}/idioma" && [[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}

# github: https://github.com/Jrohy (19/12/2019 - k8.3.1)

intallv2ray () {
apt install python3-pip -y 
source <(curl -sL https://multi.netlify.app/v2ray.sh)
msg -ama "$(fun_trans "Successfully installed ")!"
echo "#V2RAY ON" > /etc/v2ray-on
}

protocolv2ray () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Found")"
msg -bar
exit 1
fi
msg -ama "$(fun_trans "Choose option 3 and enter the domain of our IP")!"
msg -bar
v2ray stream
}

tls () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Found")"
msg -bar
exit 1
fi
msg -ama "$(fun_trans "Enable or disable TLS")!"
msg -bar
echo -ne "\033[1;97m
Tip: choose option 1.open TLS- and choose option 1 to\n
automatically generate certificates and follow the steps\n
If you make a mistake, choose option 1 again, but\n
now choose option 2 to add the routes of the certificate\n
manually.\n\033[1;93m
certificate = /root/cer.crt\n
key= /root/key.key\n\033[1;97m"
openssl genrsa -out key.key 2048 > /dev/null 2>&1
(echo ; echo ; echo ; echo ; echo ; echo ; echo ) | openssl req -new -key key.key -x509 -days 1000 -out cer.crt > /dev/null 2>&1
echo ""
v2ray tls
}

portv () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Found")"
msg -bar
exit 1
fi
msg -ama "$(fun_trans "Change v2ray port")!"
msg -bar
v2ray port
}

infocuenta () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Foundo")"
msg -bar
exit 1
fi
v2ray info
}

stats () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Found")"
msg -bar
exit 1
fi
msg -ama "$(fun_trans "Consumption Statistics ")!"
msg -bar
v2ray stats
}

unistallv2 () {
if [[ ! -e /etc/v2ray-on ]]; then
msg -ama " $(fun_trans "V2ray Not Found")"
msg -bar
exit 1
fi
source <(curl -sL https://multi.netlify.app/v2ray.sh) --remove
rm -rf /etc/v2ray-on
}

[[ -e /etc/v2ray-on ]] && OPENBAR="\033[1;32mOnline" || OPENBAR="\033[1;31mOffline"
msg -azu "$(fun_trans "MENU V2RAY")"
msg -bar
echo -ne "\033[1;32m [0] > " && msg -bra "$(fun_trans "RETURN ")"
echo -ne "\033[1;32m [1] > " && msg -azu "$(fun_trans "INSTALL V2RAY") "
echo -ne "\033[1;32m [2] > " && msg -azu "$(fun_trans "CHANGE PROTOCOL")"
echo -ne "\033[1;32m [3] > " && msg -azu "$(fun_trans "ENABLE TLS") "
echo -ne "\033[1;32m [4] > " && msg -azu "$(fun_trans "CHANGE V2RAY PORT") "
echo -ne "\033[1;32m [5] > " && msg -azu "$(fun_trans "ACCOUNT INFORMATION")"
echo -ne "\033[1;32m [6] > " && msg -azu "$(fun_trans "CONSUMPTION STATISTICS")"
echo -ne "\033[1;32m [7] > " && msg -azu "$(fun_trans "UNINSTALLING V2RAY") $OPENBAR"
msg -bar
while [[ ${arquivoonlineadm} != @(0|[1-7]) ]]; do
read -p "[0-7]: " arquivoonlineadm
tput cuu1 && tput dl1
done
case $arquivoonlineadm in
1)intallv2ray;;
2)protocolv2ray;;
3)tls;;
4)portv;;
5)infocuenta;;
6)stats;;
7)unistallv2;;
0)exit;;
esac
msg -bar
