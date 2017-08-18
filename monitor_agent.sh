#!/bin/sh
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

working_dir="/root/monitor";

cd $working_dir;

current_time=$(date '+%Y_%m_%d_%H_%M');
file_name=$current_time"_"$file_name_suffix;
echo "[SERVER_DESC]\n"$server_desc"\n">>$file_name;

$working_dir"/system_info.sh" $file_name;
#comment it if no docker in the server.
$working_dir"/docker_status.sh" $file_name;

lftp sftp"://"$sftp_user":"$sftp_password"@"$sftp_host -e "cd "$upload_path";put "$file_name";bye";

rm $file_name;
echo "DONE";