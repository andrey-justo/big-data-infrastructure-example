#!/bin/bash

# http://www.cloudera.com/content/cloudera/en/documentation/cdh4/v4-2-0/CDH4-Installation-Guide/cdh4ig_topic_18_4.html

source "/vagrant/scripts/common.sh"

function installLocalHive {
	echo "install hive from local file"
	FILE=/vagrant/resources/$HIVE_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteHive {
	echo "install hive from remote file"
	curl -sS -o /vagrant/resources/$HIVE_ARCHIVE -O -L $HIVE_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$HIVE_ARCHIVE -C /usr/local
}

function installHive {
	if resourceExists $HIVE_ARCHIVE; then
		installLocalHive
	else
		installRemoteHive
	fi
	ln -sfn /usr/local/apache-$HIVE_VERSION-bin /usr/local/hive

	mkdir -p /usr/local/hive/logs /usr/local/hive/derby/
}

function setupHive {
	echo "copying over hive configuration file"
	cp -f $HIVE_RES_DIR/* $HIVE_CONF
}

function setupEnvVars {
	echo "creating hive environment variables"
	cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
	source /etc/profile.d/hive.sh
}

function runHiveServices {
	echo "running hive metastore"
    hive --service metastore < /dev/null > /usr/local/hive/logs/hive_metastore_`date +"%Y%m%d%H%M%S"`.log 2>&1 &

	echo "running hive server2"
    hive --service hiveserver2 < /dev/null > /usr/local/hive/logs/hive_server2_`date +"%Y%m%d%H%M%S"`.log 2>&1 &
}

function mysqlDependencies {
	echo "Downloading mysql-connector"
	sudo /usr/local/bin/mvn org.apache.maven.plugins:maven-dependency-plugin:RELEASE:copy -Dartifact=mysql:mysql-connector-java:6.0.6 -DoutputDirectory=/usr/local/hive/lib -Dmdep.useBaseVersion=true
	echo "Initializing metastore schema"
	schematool -dbType mysql -initSchema --verbose
}

echo "setup hive"

installHive
setupHive
setupEnvVars
mysqlDependencies
runHiveServices

echo "hive setup complete"
