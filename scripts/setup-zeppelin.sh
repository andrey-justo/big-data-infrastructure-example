#!/bin/bash
source "/vagrant/scripts/common.sh"

function installZeppelin {
	echo "Install Zeppelin"
	if resourceExists $ZEPPELIN_ARCHIVE.tgz; then
		echo "Zeppelin already installed"
	else
		curl -sS -o /vagrant/resources/$ZEPPELIN_ARCHIVE.tgz -O -L $ZEPPELIN_MIRROR_DOWNLOAD
		tar -xzf /vagrant/resources/$ZEPPELIN_ARCHIVE.tgz -C /usr/local
		ln -sfn /usr/local/$ZEPPELIN_ARCHIVE /usr/local/zeppelin
	fi
}

function installInterpreters {
	# Install interpreters
	echo "Install interpreters for Zeppelin"
	${ZEPPELIN_HOME}/bin/install-interpreter.sh --name md,python,spark,jdbc
}

function setupZeppelin {
	echo "Setup Zeppelin"
	cp -vpR /vagrant/resources/zeppelin/shiro.ini ${ZEPPELIN_CONF_DIR}/shiro.ini
	cp -vpR /vagrant/resources/zeppelin/zeppelin-site.xml ${ZEPPELIN_CONF_DIR}/zeppelin-site.xml
	cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
	export ZEPPELIN_MEM="-Xmx512m"
	export ZEPPELIN_JAVA_OPTS="-Dspark.home=${SPARK_HOME}"
CONF
}

function startingZeppelin {
	echo "Starting Zeppelin"
	bash /usr/local/zeppelin/bin/zeppelin-daemon.sh start
}

echo "Starting Zeppelin..."

installZeppelin
installInterpreters
setupZeppelin
startingZeppelin

echo "Setup Zeppelin finalized"