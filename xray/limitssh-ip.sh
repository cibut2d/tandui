#!/bin/bash

function send_log() {
    CHATID=$(cat /etc/per/id)
    KEY=$(cat /etc/per/token)
    TIME="10"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    TEXT="
<code>────────────────────</code>
<b>⚠️ NOTIFICATIONS MULTI LOGIN SSH⚠️</b>
<code>────────────────────</code>
<code>Username          : </code><code>$user</code>
<code>Limit IP            : </code><code>${iplimit}</code>
<code>User Login         : </code><code>${cekcek}</code>
<code>Akun Locked       : </code><code>15 Menit</code>
<code>────────────────────</code>
"
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

clear

mulog=$(cekssh)
date=$(date)
data=( `ls /etc/cbt/limit/ssh/ip`)

for user in "${data[@]}"
do
    iplimit=$(cat /etc/cbt/limit/ssh/ip/$user)
    cekcek=$(echo -e "$mulog" | grep $user | wc -l)

    if [[ $cekcek -gt $iplimit ]]; then
        nais=3
        passwd -l "$user" > /dev/null
        send_log

        # Jadwalkan untuk membuka kembali akun setelah 15 menit
        echo "passwd -u $user" | at now + 15 minutes > /dev/null
    else
        echo > /dev/null
    fi

    sleep 0.1
done

echo > /dev/null
