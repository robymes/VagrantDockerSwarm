Vagrant.require_version ">= 1.8.5"

ENV["LC_ALL"] = "en_US.UTF-8"

swarm_manager_count = 1
swarm_worker_count = 2

Vagrant.configure("2") do |config|

  (1..swarm_manager_count).each do |i|
    config.vm.define "manager0#{i}" do |manager|
      manager.vm.box = "ubuntu/xenial64"
      manager.vm.provision :shell, path: "manager0x.sh"
      manager.vm.hostname = "manager0#{i}"
      manager.vm.network "private_network", ip: "10.0.7.1#{i}"
    end
  end

  (1..swarm_worker_count).each do |i|
    config.vm.define "worker0#{i}" do |worker|
      worker.vm.box = "ubuntu/xenial64"
      worker.vm.provision :shell, path: "worker0x.sh"
      worker.vm.hostname = "worker0#{i}"
      worker.vm.network "private_network", ip: "10.0.7.10#{i}"      
    end
  end

  config.vm.define "lb" do |lb|
    lb.vm.box = "ubuntu/xenial64"
    lb.vm.provision :shell, path: "nginx.sh"
    lb.vm.hostname = "loadbalancer"
    lb.vm.network "private_network", ip: "10.0.7.5"
    lb.vm.network "forwarded_port", guest: 80, host: 80
    lb.vm.network "forwarded_port", guest: 8080, host: 8080
    lb.vm.network "forwarded_port", guest: 27017, host: 27017
    lb.vm.network "forwarded_port", guest: 15672, host: 15672
  end

end