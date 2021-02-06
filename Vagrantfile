Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/groovy64"

  config.vm.provider :virtualbox do |v|
    v.gui = true
    if RUBY_PLATFORM =~ /darwin/
      v.customize ["modifyvm", :id, '--audio', 'coreaudio', '--audiocontroller', 'hda'] # choices: hda sb16 ac97
    elsif RUBY_PLATFORM =~ /mingw|mswin|bccwin|cygwin|emx/
      v.customize ["modifyvm", :id, '--audio', 'dsound', '--audiocontroller', 'ac97']
    end
    v.memory = 16192
    v.cpus = 6
  end

  # Run internal provisioning
  #config.vm.provision :shell, :inline => $BOOTSTRAP_SCRIPT # see below
end

$BOOTSTRAP_SCRIPT = <<EOF
 sudo /vagrant/provision.sh
EOF
