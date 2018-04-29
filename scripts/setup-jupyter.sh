#!/bin/bash
source "/vagrant/scripts/common.sh"
source "$HADOOP_CONF/yarn-env.sh"

function installJupyter {
	echo "install jupyter"
	pip3.6 install --upgrade pip
	pip3.6 install ipython==6.3.1
	pip3.6 install jupyter==1.0.0
	pip3.6 install tornado==4.5.3
}

function configureSparkMagic {
    echo "configure spark magic"
    pip3.6 install sparkmagic==0.12.5
    jupyter nbextension enable --py --sys-prefix widgetsnbextension
    cd /usr/lib/python3.6/site-packages/
    jupyter-kernelspec install sparkmagic/kernels/sparkkernel
    jupyter-kernelspec install sparkmagic/kernels/pysparkkernel
}

function configureJupyter {
	echo "configure jupyter"
	ln -sfn /vagrant/resources/jupyter /usr/local/jupyter
	mkdir -p /usr/local/jupyter-notebooks
	cp /vagrant/resources/pyspark-sample.ipynb /usr/local/jupyter-notebooks
	configureKerberusLib
	configureSparkMagic
	jupyter serverextension enable --py sparkmagic
	mkdir -p ~/.sparkmagic
	cp /vagrant/resources/jupyter/spark-magic-config.json ~/.sparkmagic/config.json
	jupyter notebook --ip=0.0.0.0 --config=/usr/local/jupyter/jupyter_notebook_config.py --no-browser &
}

function configureKerberusLib {
    sudo yum install -y krb5-devel
}
echo "setup jupyter"
installJupyter
configureJupyter
