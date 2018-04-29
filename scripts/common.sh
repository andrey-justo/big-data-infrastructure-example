#!/bin/bash

# locale
## US English ##
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8

# hadoop
# Spark is compatible with hadoop 2 -> https://issues.apache.org/jira/browse/SPARK-18673
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.7.2
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/$HADOOP_VERSION/$HADOOP_ARCHIVE
HADOOP_RES_DIR=/vagrant/resources/hadoop

# hive
HIVE_VERSION=hive-2.3.3
HIVE_ARCHIVE=apache-$HIVE_VERSION-bin.tar.gz
HIVE_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hive/$HIVE_VERSION/$HIVE_ARCHIVE
HIVE_RES_DIR=/vagrant/resources/hive
HIVE_CONF=/usr/local/hive/conf

# spark
SPARK_VERSION=spark-2.3.0
SPARK_ARCHIVE=$SPARK_VERSION-bin-hadoop2.7.tgz
SPARK_MIRROR_DOWNLOAD=http://archive.apache.org/dist/spark/$SPARK_VERSION/$SPARK_VERSION-bin-hadoop2.7.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf

# zeppelin
ZEPPELIN_VERSION=zeppelin-0.7.3
ZEPPELIN_ARCHIVE=$ZEPPELIN_VERSION-bin-netinst
ZEPPELIN_MIRROR_DOWNLOAD=http://archive.apache.org/dist/zeppelin/${ZEPPELIN_VERSION}/${ZEPPELIN_VERSION}-bin-netinst.tgz
ZEPPELIN_RES_DIR=/vagrant/resources/zeppelin
ZEPPELIN_HOME=/usr/local/zeppelin
ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook

# jupyter
export PYSPARK_PYTHON=python3.6
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --config=/usr/local/jupyter/jupyter_notebook_config.py --no-browser --allow-root'
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip

# apache ranger
RANGER_VERSION=1.0.0
RANGER_ARCHIVE=apache-ranger-$RANGER_VERSION.tar.gz
RANGER_MIRROR_DOWNLOAD=http://archive.apache.org/dist/ranger/$RANGER_VERSION/$RANGER_ARCHIVE
RANGER_RES_DIR=/vagrant/resources/ranger

# livy
LIVY_VERSION=0.5.0
LIVY_ARCHIVE=livy-$LIVY_VERSION-incubating-bin
LIVY_MIRROR_DOWNLOAD=http://apache.dattatec.com/incubator/livy/$LIVY_VERSION-incubating/livy-$LIVY_VERSION-incubating-bin.zip
export LIVY_SERVER_JAVA_OPTS="-Dlivy.server.session.factory=yarn -Dlivy.spark.deployMode=client -Dlivy.spark.master=yarn -Dlivy.server.host=10.211.55.101"

# ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

# java
JAVA_HOME=/usr/local/java

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}
