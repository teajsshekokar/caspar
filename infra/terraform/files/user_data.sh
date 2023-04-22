#!/bin/bash

yum_wait () {
  while [[ $(ps -ef | grep 'yum' | grep -v 'grep' | wc -l) -gt 0 ]]; do
    echo 'Waiting for yum lock';
    sleep 5;
  done
}

yum_wait
amazon-linux-extras install epel -y
yum -y update
yum -y upgrade
yum_wait
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip3 install -U pip

#INSTALL MINIKUBE
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start
