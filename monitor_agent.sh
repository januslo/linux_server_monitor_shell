#!/bin/sh -e
#The agent of the monitor, for generating the information file and transfers to the specified SFTP location.
#Author: Janus J K Lu
#Date 2017-08-17
#############################################################################################################

#Configurations:

# file_name_prefix: the prefix of the name exported, host name or ip address would be just fine.
file_name_suffix="";

# sftp_host: the host of the sftp where exported file upload to, ;
sftp_host="";

# sftp_user: the user of the sftp
sftp_user="";

#sftp_password: password of the sftp.
sftp_password="";

#upload_path: the path of the sftp server where file upload to.
upload_path="";
#server_desc: the short description the the current server
server_desc="";

#Limits the existing file count, we see the processor of server is death if the max_exist_file_count reached.
max_exist_file_count=100;

#need to enter the working dir manually in the Cron job.
working_dir="";

cd $working_dir;

current_time=$(date '+%Y_%m_%d_%H_%M');
file_name=$current_time"_"$file_name_suffix;
tem_file_name="tem_"$file_name;
lftp sftp"://"$sftp_user":"$sftp_password"@"$sftp_host -e "cd "$upload_path";ls;bye;">>$tem_file_name;
exist_count=$(cat $tem_file_name | grep '^-' | grep -E '*'$file_name_suffix | wc -l);
rm $tem_file_name;
if [ -n "$exist_count" ] && [ $exist_count -gt $max_exist_file_count ];then
echo 'reach max exist file count:'$max_exist_file_count', actully got count: '$exist_count', exit.'
exit 0;
fi
#echo "exist_count:"$exits_count;
#rm $tem_file_name;
echo "[SERVER_DESC]\n"$server_desc"\n">>$file_name;

$working_dir"/system_info.sh" $file_name;
#echo 1;
#comment it if no docker in the server.
$working_dir"/docker_status.sh" $file_name;
#echo 2;

lftp sftp"://"$sftp_user":"$sftp_password"@"$sftp_host -e "cd "$upload_path";put "$file_name";bye;";

rm $file_name;
echo "DONE";

