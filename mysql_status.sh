#!/usr/bin/env bash
out_file_name=${1};
mysql_url="";
mysql_user="";
mysql_pwd="";
echo "[MYSQL GLOBAL]\n">>$out_file_name;
echo "mysql_host "$mysql_url>>$out_file_name;
mysql -h $mysql_url -u $mysql_user --password=$mysql_pwd -e  " show global status;">>$out_file_name;
echo "\n[END MYSQL GLOBAL]\n">>$out_file_name;
echo "[MYSQL VARIABLES]\n">>$out_file_name;
mysql -h $mysql_url -u $mysql_user --password=$mysql_pwd -e  " show variables;">>$out_file_name;
echo "\n[END VARIABLES]\n">>$out_file_name;