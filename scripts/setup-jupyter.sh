#!/bin/bash
source "/vagrant/scripts/common.sh"
source "$HADOOP_CONF/yarn-env.sh"

function installJupyter {
	echo "install jupyter"
	pip3.6 install --upgrade pip
	pip3.6 install ipython==6.3.1
	pip3.6 install jupyter==1.0.0
}

function configureJupyter {
	echo "configure jupyter"
	ln -sfn /vagrant/resources/jupyter /usr/local/jupyter
	mkdir -p /usr/local/jupyter-notebooks
	$SPARK_HOME/bin/pyspark &
}

echo "setup jupyter"
installJupyter
configureJupyter
