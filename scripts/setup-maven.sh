#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup maven"

wget -q "http://apache.dattatec.com/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz"

mkdir -p /usr/local/maven
tar zxf apache-maven-3.5.3-bin.tar.gz -C /usr/local/maven
ln -sfn /usr/local/maven/apache-maven-3.5.3/bin/mvn /usr/local/bin/mvn