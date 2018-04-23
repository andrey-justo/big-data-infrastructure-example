#!/bin/bash

source "/vagrant/scripts/common.sh"

function downloadRanger {
	echo "Downloading Apache Ranger"
	if [ -d "/usr/local/ranger" ]; then
		echo "Apache Ranger already installed and compiled"
	else
		curl -sS -o /vagrant/resources/$RANGER_ARCHIVE -O -L $RANGER_MIRROR_DOWNLOAD
		tar -xzf /vagrant/resources/$RANGER_ARCHIVE -C /usr/local
		buildRanger
	fi
}

function buildRanger {
	echo "Building Apache Ranger"
	cd /usr/local/apache-ranger-$RANGER_VERSION
	/usr/local/bin/mvn clean
	/usr/local/bin/mvn -DskipTests=true clean compile package install assembly:assembly
	ln -sfn /usr/local/apache-ranger-$RANGER_VERSION/target /usr/local/ranger
	installRanger
}

function installRanger {
	echo "Install Apache Ranger Modules"
	echo "Install Apache Ranger Admin"
	cd /usr/local/ranger
	tar zxf ranger-$RANGER_VERSION-admin.tar.gz
	cp /vagrant/resources/apache-ranger/ ranger-$RANGER_VERSION-admin/
	bash setup.sh
}

function startRanger {
	echo "Running Ranger setup script from $FULL_RANGER_DIR..."
	bash /usr/local/ranger/set_globals.sh
	bash /usr/local/ranger/setup.sh
}

echo "setup apache ranger"
downloadRanger
installRanger
startRanger
