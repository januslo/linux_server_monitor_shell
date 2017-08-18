#!/bin/sh
# Exports the system information with the following commands:
# uptime
# free
# df -h
# apache2:  curl http://127.0.0.1/server-status   -- Need status module enabled.
# ip: ifconfig | perl -nle 's/dr:(\S+)/print $1/e' | grep '^10\.' -v | grep '^172\.' -v |grep '^127\.0\.0\.' -v
#
#Input parameters: filename
#Author: Janus J K Lu
#Date 2017-08-17
#############################################################################################################

current_time=$(date '+%Y-%m-%d %H:%M');
out_file_name=${1};
echo "[SYSTEM INFORMATION]\n">>$out_file_name;
echo "[IP ADDRESS]">>$out_file_name;
(/sbin/ifconfig | perl -nle 's/dr:(\S+)/print $1/e' | grep '^10\.' -v | grep '^172\.' -v |grep '^127\.0\.0\.' -v) >> $out_file_name;
echo "\n[CURRENT TIME]\n"$current_time"\n">>$out_file_name;
echo "[CPU STATUS]\n">>$out_file_name;
uptime>>$out_file_name;
echo "[MEM STATUS]\n">>$out_file_name;
free>>$out_file_name;
echo "\n[DISK STATUS]">>$out_file_name;
df -h>>$out_file_name;
echo "\n[APACHE STATUS]">>$out_file_name;
curl http://127.0.0.1/server-status >> $out_file_name;
echo "\n";