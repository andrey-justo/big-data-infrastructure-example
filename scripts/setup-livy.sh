#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLivy {
	echo "Install Livy"
	if resourceExists $LIVY_ARCHIVE.zip; then
		echo "Livy already installed"
	else
		curl -sS -o /vagrant/resources/$LIVY_ARCHIVE.zip -O -L $LIVY_MIRROR_DOWNLOAD
		unzip /vagrant/resources/$LIVY_ARCHIVE -d /usr/local
		ln -sfn /usr/local/$LIVY_ARCHIVE /usr/local/livy
	fi
}

function startingLivy {
	echo "Starting Livy"
	source "/vagrant/resources/hive/hive.sh"
	source "/vagrant/resources/spark/spark.sh"
	bash /usr/local/livy/bin/livy-server start
}

echo "Setting up Livy..."

installLivy
startingLivy

echo "Setup Livy finalized"