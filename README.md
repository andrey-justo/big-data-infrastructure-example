Basic infrastructure configurations for Big Data solutions
==================================

# Introduction

Vagrant project to spin up a single virtual machine running:

* Hadoop 2.7.2
* Hive 2.3.3
* Spark 2.3.0

The virtual machine will be running the following services:

* HDFS NameNode + NameNode
* YARN ResourceManager + JobHistoryServer + ProxyServer
* Hive metastore and server2
* Mysql for hive catalog
* Spark history server
* Zeppelin 0.7.3
* Jupyter + Spark Magic
* Livy

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Run ```vagrant box add centos/7```
4. Go to [releases](https://github.com/alexholmes/vagrant-hadoop-spark-hive/releases) and download and extract the latest source of this project.
5. In your terminal change your directory into the project directory (i.e. `cd vagrant-hadoop-spark-hive-<version>`).
6. Run ```vagrant up``` to create the VM.
7. Execute ```vagrant ssh``` to login to the VM.

# Web user interfaces

Here are some useful links to navigate to various UI's:

* YARN resource manager:  (http://10.211.55.101:8088)
* Job history:  (http://10.211.55.101:19888/jobhistory/)
* HDFS: (http://10.211.55.101:50070/dfshealth.html)
* Spark history server: (http://10.211.55.101:18080)
* Spark context UI (if a Spark context is running): (http://10.211.55.101:4040)
* Zeppelin UI: (http://10.211.55.101:8082) - (Default login: admin/admin) - If installed
* Jupyter UI: (http://10.211.55.101:8888)
* Livy: (http://10.211.55.101:8998)

# Validating your virtual machine setup

To test out the virtual machine setup, and for examples of how to run
MapReduce, Hive and Spark, head on over to [VALIDATING.md](VALIDATING.md).

# Apache Ranger

Apache ranger is a tool to audit and give security centralization across Hadoop Platform
```vagrant up ranger```

# Starting services in the event of a system restart

Currently if you restart your VM then the Hadoop/Spark/Hive services won't be
up (this is something I'll address soon).  In the interim you can run the
following commands to bring them up:

```
$ vagrant ssh
$ sudo -s
$ /vagrant/scripts/start-hadoop.sh
$ nohup hive --service metastore < /dev/null > /usr/local/hive/logs/hive_metastore_`date +"%Y%m%d%H%M%S"`.log 2>&1 </dev/null &
$ nohup hive --service hiveserver2 < /dev/null > /usr/local/hive/logs/hive_server2_`date +"%Y%m%d%H%M%S"`.log 2>&1 </dev/null &
$ /usr/local/spark/sbin/start-history-server.sh

```


# More advanced setup

If you'd like to learn more about working and optimizing Vagrant then
take a look at [ADVANCED.md](ADVANCED.md).

# Credits

This project is based on the great work carried out at
(https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1).
