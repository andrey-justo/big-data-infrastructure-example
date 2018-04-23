#!/bin/bash
source "/vagrant/scripts/common.sh"

echo "Installing python 3.6"

yum update
yum install -y yum-utils
yum groupinstall development
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum update
yum install -y python36u python36u-libs python36u-devel python36u-pip
python3.6 -V
