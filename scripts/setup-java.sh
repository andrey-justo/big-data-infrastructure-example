#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteJava {
	echo "install open jdk"
	yum install -y java-1.8.0-openjdk-devel-1:1.8.0.161-0.b14.el7_4.x86_64
	ln -sfn /usr/lib/jvm/java-openjdk/ /usr/local/java
}

echo "setup java"
installRemoteJava
