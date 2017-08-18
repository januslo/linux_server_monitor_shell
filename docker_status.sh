#!/bin/sh
# Exports the information with "docker ps " command and "docker stats  --no-stream"
#Input parameters: filename
#Author: Janus J K Lu
#Date 2017-08-17
#############################################################################################################

out_file_name=${1};
echo "[DOCKER INFORMATION]\n">>$out_file_name;
echo "[DOCKER PROCESSES]\n">>$out_file_name;
docker ps>>$out_file_name;
echo "\n">>$out_file_name;
echo "[DOCKER STATUS]\n">>$out_file_name;
docker stats  --no-stream>>$out_file_name;
echo "\n">>$out_file_name;