#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

###########- COLOR CODE -##############
colornow=$(cat /etc/julak/theme/color.conf)
VC="\e[0m"
Green="\e[92;1m"
BICyan='\033[1;96m'
BIYellow='\033[1;93m'
COLOR1="$(cat /etc/julak/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/julak/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
y='\033[1;33m' #yellow
l='\033[0;37m'
BGX="\033[42m"
CYAN="\033[96m"
z="\033[96m"
zx="\033[97;1m" # // putih
RED='\033[0;31m'
NC='\033[0m'
gray="\e[1;30m"
Blue="\033[0;34m"
green='\033[1;32m'
grenbo="\e[92;1m"
purple="\033[1;95m"
YELL='\033[0;33m'
cyan="\033[1;36m"
c="\033[5;33m"
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/cibut2d/reg/main/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/cibut2d/reg/main/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/cibut2d/reg/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
echo -e " $COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• TERIMA KASIH SUDAH •          ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• MENGGUNAKAN SCRIPT •          ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• PREMIUM DARI SAYA  •          ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• KALAU ADA KENDALA  •          ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• CHAT SAYA LEWAT WA •          ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}        ${WH}• https:/wa.me/6281250851741 •      ${NC} $COLOR1 $NC"
echo -e " $COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " $COLOR1┌─────────────────────────────────────────────────┐${NC}"
read -rp "  New ID CHAT TELEGRAM : " -e id
echo "$id" > /etc/per/id
echo -e " $COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
sleep 2
read -rp "  New TOKEN BOT TELEGRAM : " -e token
echo "$token" > /etc/per/token
sleep 3
echo -e " $COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to menu"
menu
fi