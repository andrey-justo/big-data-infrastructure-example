#!/usr/bin/env bash

# Full path to location of Ranger source code
RANGER_HOME=/home/myuser/incubator-ranger

# Database passwords
DB_ROOT_PASSWORD=admin
DB_PASSWORD=admin
AUDIT_DB_PASSWORD=admin

INSTALL_SOLR=false

# for audit logs
SOLR_TAR=
SOLR_INSTALL_DIR=
AUDIT_SOLR_URLS=

SUPPORTED_COMPONENTS=tag,hdfs,hbase,hive,kms,knox,storm,yarn,kafka,solr,atlas,nifi
