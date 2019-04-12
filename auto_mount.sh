#!/bin/bash
# $1 = Azure storage account name
# $2 = Azure storage account key
# $3 = Azure file share name
# $4 = mountpoint path
# $5 - username

if [ -d "/data" ] 
then
    sudo mount -t cifs //$1.file.core.windows.net/$3 $4 -o vers=3.0,username=$1,password=$2,dir_mode=0777,file_mode=0777,sec=ntlmssp
else
    sudo mkdir -p /data/boomi && sudo mkdir /data/files && sudo mkdir /data/export && sudo chmod 777 /data && sudo chmod 777 /data/boomi && sudo chmod 777 /data/files && sudo chmod 777 /data/export
fi

sudo mount -t cifs //$1.file.core.windows.net/$3 $4 -o vers=3.0,username=$1,password=$2,dir_mode=0777,file_mode=0777,sec=ntlmssp

sudo mkdir /opt/boomi
sudo mkdir /opt/boomi/local
sudo chmod -R 777 /opt/boomi/
sudo chmod -R 777 /opt/boomi/local
sudo chmod -R 777 /tmp
