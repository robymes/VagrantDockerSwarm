Vagrant.require_version ">= 1.8.5"

ENV["LC_ALL"] = "en_US.UTF-8"

swarm_node_count = 2

Vagrant.configure("2") do |config|

  config.vm.define "manager01" do |manager01|
    manager01.vm.box = "ubuntu/trusty64"
    manager01.vm.provision :shell, path: "manager01.sh"
    manager01.vm.hostname = "manager01"
    manager01.vm.network "private_network", ip: "10.0.7.11"
    manager01.vm.network "forwarded_port", guest: 27017, host: 27017
  end

  (1..swarm_node_count).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "ubuntu/trusty64"
      worker.vm.provision :shell, path: "worker0x.sh"
      worker.vm.hostname = "worker0#{i}"
      worker.vm.network "private_network", ip: "10.0.7.10#{i}"      
    end
  end

  config.vm.define "lb" do |lb|
    lb.vm.box = "ubuntu/trusty64"
    lb.vm.provision :shell, path: "nginx.sh"
    lb.vm.hostname = "loadbalancer"
    lb.vm.network "private_network", ip: "10.0.7.5"
    lb.vm.network "forwarded_port", guest: 80, host: 8080
  end

end