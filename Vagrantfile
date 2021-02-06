Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/groovy64"

  config.vm.provider :virtualbox do |v|
    v.gui = true
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.memory = 16192
    v.cpus = 6
  end

  # Add Google Chrome repository
  config.vm.provision :shell, inline: "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -"
  config.vm.provision :shell, inline: "sudo sh -c 'echo \"deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\" > /etc/apt/sources.list.d/google.list'"

  # Update repositories
  config.vm.provision :shell, inline: "sudo apt update -y"

  # Upgrade installed packages
  config.vm.provision :shell, inline: "sudo apt upgrade -y"

  # Add desktop environment
  config.vm.provision :shell, inline: "sudo apt install -y --no-install-recommends ubuntu-desktop"
  
  # Add `vagrant` to Administrator
  config.vm.provision :shell, inline: "sudo usermod -a -G sudo vagrant"

  # Run internal provisioning
  config.vm.provision :shell, inline: "sudo /vagrant/provision.sh"

end
