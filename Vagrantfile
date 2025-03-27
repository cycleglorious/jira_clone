# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network :private_network, ip: "192.168.57.10"
  config.vm.network "forwarded_port", guest: 30080, host: 30080
  config.vm.hostname = "docker"
  config.vm.synced_folder ".", "/home/vagrant/jira-clone/"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "6144"
    vb.name = "docker"
  end
end
