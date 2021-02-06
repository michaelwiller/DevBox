#! /usr/bin/env bash

if [ ! -f $HOME/runonce ]; then
    touch $HOME/runonce
	usermod -a -G audio vagrant
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
	apt update -y
	apt upgrade -y
	apt install -y --no-install-recommends ubuntu-desktop
    apt install -y build-essentials linux-headers-$(uname -r)
	shutdown -r now
fi

cat /vagrant/packages.txt | xargs sudo apt -y install
