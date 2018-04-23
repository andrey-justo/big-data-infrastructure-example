Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "centos/7"

    config.vm.define "spark-yarn-master-worker", primary: true do |node|
        node.vm.network :private_network, ip: "10.211.55.101"
        node.vm.hostname = "10.211.55.101"
        node.vm.provider "virtualbox" do |v|
          v.name = "master-worker"
          v.customize ["modifyvm", :id, "--memory", "2048"]
        end

        node.vm.provision "shell", path: "scripts/setup-centos.sh"
        node.vm.provision "shell", path: "scripts/setup-java.sh"
        node.vm.provision "shell", path: "scripts/setup-python.sh"
        node.vm.provision "shell", path: "scripts/setup-maven.sh"
        node.vm.provision "shell", path: "scripts/setup-mysql.sh"
        node.vm.provision "shell", path: "scripts/setup-hadoop.sh"
        node.vm.provision "shell", path: "scripts/setup-hive.sh"
        node.vm.provision "shell", path: "scripts/setup-spark.sh"
        node.vm.provision "shell", path: "scripts/setup-jupyter.sh"
        #node.vm.provision "shell", path: "scripts/setup-zeppelin.sh"
        node.vm.provision "shell", path: "scripts/finalize-centos.sh"
    end

    config.vm.define "ranger", autostart: false do |ranger|
        ranger.vm.network :private_network, ip: "10.211.55.102"
        ranger.vm.hostname = "10.211.55.102"
        ranger.vm.provider "virtualbox" do |v|
          v.name = "master-worker"
          v.customize ["modifyvm", :id, "--memory", "2048"]
        end

        ranger.vm.provision "shell", path: "scripts/setup-centos.sh"
        ranger.vm.provision "shell", path: "scripts/setup-java.sh"
        ranger.vm.provision "shell", path: "scripts/setup-maven.sh"
        ranger.vm.provision "shell", path: "scripts/setup-apache-ranger.sh"
        ranger.vm.provision "shell", path: "scripts/finalize-centos.sh"
    end

    config.vm.define "scheduler", autostart: false do |scheduler|
    end
end

