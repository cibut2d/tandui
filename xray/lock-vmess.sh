#!/bin/bash

# Kunci akun selama 15 menit
sleep 900

function send_log(){
CHATID=$(cat /etc/per/id)
KEY=$(cat /etc/per/token)
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<code>────────────────────</code>
<b>⚠️ NOTIFICATIONS MULTI LOGIN XRAY ⚠️</b>
<code>────────────────────</code>
<code>Username  : </code><code>$user</code>
<code>Limit Ip    : </code><code>${iplimit}</code>
<code>Login Ip    : </code><code>${cekcek}</code>
<code>────────────────────</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

function activate_account(){
  local user="$1"
  local exp="$2"
  
  # Tambahkan kembali konfigurasi akun setelah 15 menit
  # Sesuaikan dengan logika penyimpanan konfigurasi akun Anda
  echo "### $user $exp" >> /etc/xray/config.json
  systemctl restart xray >> /dev/null 2>&1
}

function vmess1(){
  # Batasi multi login hanya untuk vmess
  data=( `ls /etc/cbt/limit/vmess/ip`);

  for user in "${data[@]}"
  do
    iplimit=$(cat /etc/cbt/limit/vmess/ip/$user)
    ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
    cekcek=$(echo -e "$ehh" | wc -l);

    if [[ $cekcek -gt $iplimit ]]; then
      exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
      sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^#vmg $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^### $user $exp/d" /etc/vmess/.vmess.db
      systemctl restart xray >> /dev/null 2>&1
      jum2=$(cat /tmp/ipvmess.txt | wc -l)
      rm -rf /etc/cbt/limit/vmess/ip/$user
      send_log

      # Menunggu selama 15 menit sebelum mengaktifkan kembali akun
      sleep 900

      # Panggil fungsi untuk mengaktifkan kembali akun
      activate_account "$user" "$exp"
    else
      echo ""
    fi
    sleep 0.1
  done
}

function vless1(){
  # Batasi multi login hanya untuk vless
  data=( `ls /etc/cbt/limit/vless/ip`);

  for user in "${data[@]}"
  do
    iplimit=$(cat /etc/cbt/limit/vless/ip/$user)
    ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
    cekcek=$(echo -e "$ehh" | wc -l);

    if [[ $cekcek -gt $iplimit ]]; then
      exp=$(grep -w "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
      sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^#vlg $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^### $user $exp/d" /etc/vless/.vless.db
      systemctl restart xray >> /dev/null 2>&1
      jum2=$(cat /tmp/ipvless.txt | wc -l)
      rm -rf /etc/cbt/limit/vless/ip/$user
      send_log

      # Menunggu selama 15 menit sebelum mengaktifkan kembali akun
      sleep 900

      # Panggil fungsi untuk mengaktifkan kembali akun
      activate_account "$user" "$exp"
    else
      echo ""
    fi
    sleep 0.1
  done
}

function trojan1(){
  # Batasi multi login hanya untuk trojan
  data=( `ls /etc/cbt/limit/trojan/ip`);

  for user in "${data[@]}"
  do
    iplimit=$(cat /etc/cbt/limit/trojan/ip/$user)
    ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
    cekcek=$(echo -e "$ehh" | wc -l);

    if [[ $cekcek -gt $iplimit ]]; then
      exp=$(grep -w "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
      sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^#trg $user $exp/,/^},{/d" /etc/xray/config.json
      sed -i "/^### $user $exp/d" /etc/trojan/.trojan.db
      systemctl restart xray >> /dev/null 2>&1
      jum2=$(cat /tmp/iptrojan.txt | wc -l)
      rm -rf /etc/cbt/limit/trojan/ip/$user
      send_log

      # Menunggu selama 15 menit sebelum mengaktifkan kembali akun
      sleep 900

      # Panggil fungsi untuk mengaktifkan kembali akun
      activate_account "$user" "$exp"
    else
      echo ""
    fi
    sleep 0.1
  done
}

function shadowsocks1(){
  # Batasi multi login hanya untuk shadowsocks
  data=( `ls /etc/cbt/limit/shadowsocks/ip`);

  # Check your Account
for user in ${data[@]}
do
  if [ -e /etc/shadowsocks/${user} ]; then
    checkLimit=$(cat /etc/shadowsocks/${user});
    if [[ ${#checkLimit} -gt 1 ]]; then
      if [ -e /etc/limit/shadowsocks/${user} ]; then
        Usage=$(cat /etc/limit/shadowsocks/${user});
        if [[ ${Usage} -gt ${checkLimit} ]]; then
          exp=$(grep -w "^#!# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
          sed -i "/^#ss# $user $exp/,/^},{/d" /etc/xray/config.json
          sed -i "/^### $user $exp/d" /etc/shadowsocks/.shadowsocks.db
          bol=$(cat /etc/limit/shadowsocks/${user});
          total=$(con ${bol})
          send_log
          rm -f /etc/shadowsocks/$user
          rm -f /etc/cbt/limit/shadowsocks/ip/${user}
          rm -f /etc/limit/shadowsocks/$user
          rm -f /etc/limit/shadowsocks/quota/$user

          # Menunggu selama 15 menit sebelum mengaktifkan kembali akun
          sleep 900

          # Panggil fungsi untuk mengaktifkan kembali akun
          activate_account "$user" "$exp"
        else
          echo ""
        fi
      else
        echo ""
      fi
    else
      echo ""
    fi
  else
    echo ""
  fi
done

# Pilih fungsi sesuai kebutuhan
# vmess1
# vless1
# trojan1
# shadowsocks1
