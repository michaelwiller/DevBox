Vagrant.configure("2") do |config|
  $audio = "coreaudio"
  $audiocontroller = "hda" # choices: hda sb16 ac97

  if RUBY_PLATFORM =~ /darwin/
    $audio = "coreaudio"
    $audiocontroller = "hda" # choices: hda sb16 ac97
  elsif RUBY_PLATFORM =~ /mingw|mswin|bccwin|cygwin|emx/
    $audio="dsound"
    $audiocontroller="ac97"
  end

  config.vm.box = "ubuntu/groovy64"

  config.vm.provider :virtualbox do |v|
    v.gui = true
    v.customize ["modifyvm", :id, '--audio', :audio, '--audiocontroller', :audiocontroller ]
    v.memory = 16192
    v.cpus = 6
  end

  # Run internal provisioning
  config.vm.provision :shell, :inline <<-SHELL 
    sudo /vagrant/provision.sh
  SHELL
end
