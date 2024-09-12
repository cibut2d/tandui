## Project Pribadi Silahkan Fork Sendiri

### UPDATE FOR DEBIAN
<pre><code>apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot</code></pre>

### UPDATE FOR UBUNTU
<pre><code>apt update && apt upgrade -y && update-grub && sleep 2 && reboot</code></pre>

### INSTALL SCRIPT 
<pre><code>sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/cibut2d/tandui/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
</code></pre>

### PERINTAH UPDATE 
<pre><code>wget https://raw.githubusercontent.com/cibut2d/tandui/main/menu/update.sh && chmod +x update.sh && ./update.sh</code></pre>

### TESTED ON OS 
- UBUNTU 18 & UP
- DEBIAN 10 & UP

### PORT INFO
```
- TROJAN WS 443
- TROJAN GRPC 443
- SHADOWSOCKS WS 443 (OF) Tambahkan Masing2
- SHADOWSOCKS GRPC 443 (OF) Tambahkan Masing2
- VLESS WS 443
- VLESS GRPC 443
- VLESS NONTLS 80
- VMESS WS 443
- VMESS GRPC 443
- VMESS NONTLS 80
- SSH TLS 447 / 8443
- SSH WS / TLS 443
- SSH WS NON TLS 80 / 2052
- OVPN SSL/TCP 1194 (OF) Tambahkan Masing2
- SLOWDNS 5300 (OF) Tambahkan Masing2
```
### Author
```
```
Julak Bantur :<a href="https://t.me/Cibut2d" target=”_blank”><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=Telegram&label=Telegram&message=Click%20Here&color=blue"></a><br>
```
```
``
```
