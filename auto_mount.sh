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

sudo mount -t cifs //$1.file.core.windows.net/$3 $4 -o nofail,vers=3.0,username=$1,password=$2,dir_mode=0777,file_mode=0777,serverino,cache=strict

sudo mkdir /opt/boomi
sudo mkdir /opt/boomi/local
sudo chmod -R 777 /opt/boomi/
sudo chmod -R 777 /opt/boomi/local
sudo chmod -R 777 /tmp

sudo cp /data/jdk-8u211-linux-x64.tar.gz /home/docker/jdk-8u211-linux-x64.tar.gz
sudo mkdir /opt/java-jdk
sudo tar -C /opt/java-jdk -zxf /home/docker/jdk-8u211-linux-x64.tar.gz
sudo update-alternatives --install /usr/bin/java java /opt/java-jdk/jdk1.8.0_211/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /opt/java-jdk/jdk1.8.0_211/bin/javac 1

export INSTALL4J_JAVA_HOME=/opt/java-jdk/jdk1.8.0_211/jre
sudo rm /home/docker/jdk-8u211-linux-x64.tar.gz
sudo cp /data/container-launcher.jar /data/boomi/lib/container-launcher.jar
sudo /data/boomi/bin/atom start
