#!/bin/bash
source "/vagrant/scripts/common.sh"

function installJupyter {
	echo "install jupyter"
	pip3.6 install --upgrade pip
	pip3.6 install ipython==5.0.0
	pip3.6 install jupyter
}

function configureJupyter {
	echo "configure jupyter"
	ln -sfn /vagrant/resources/jupyter /usr/local/jupyter
	jupyter notebook --ip=0.0.0.0 --config=/usr/local/jupyter/jupyter_notebook_config.py --no-browser --allow-root &
}

echo "setup jupyter"
installJupyter
configureJupyter
