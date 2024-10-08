#!/bin/bash

read -p "Masukkan nama pengguna: " user
limit_file="/etc/cbt/limit/ssh/ip/$user"

# Validasi apakah file batasan IP sudah ada
if [ -e "$limit_file" ]; then
  current_iplimit=$(cat "$limit_file")
  echo "Batasan IP saat ini untuk pengguna $user: $current_iplimit"
  
  read -p "Masukkan batasan IP baru: " new_iplimit

  # Validasi jika masukan kosong
  if [ -z "$new_iplimit" ]; then
    echo "Masukan tidak valid. Batasan IP tidak berubah."
  else
    echo "$new_iplimit" > "$limit_file"
    echo "Batasan IP berhasil diubah menjadi $new_iplimit untuk pengguna $user."
  fi
else
  echo "File batasan IP tidak ditemukan untuk pengguna $user."
fi
