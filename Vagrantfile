# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # VM CONFIG
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    #vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = 4
  end
  
  # PROVISIONING
  config.vm.provision "shell", path: "bootstrap.sh"

end
