# -*- mode: ruby -*-
# vi: set ft=ruby :

#VendorId:	0x0b95 (0B95)5
#ProductId:	0x772a (772A)

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (Wireless)"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Pineapple', '--vendorid', '0x0b95', '--productid', '0x772a']
  end
end
