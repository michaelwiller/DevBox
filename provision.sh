#! /usr/bin/env bash

cd $HOME

if [ ! -f /var/.provision.done ]; then
    echo "DONE" >> /var/.provision.done
	usermod -a -G audio vagrant
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -
	#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
	apt update -y
	apt upgrade -y
	apt install -y --no-install-recommends ubuntu-desktop
    apt install -y build-essential linux-headers-$(uname -r)
    shutdown -r now
fi

# Clone default repositories
[ ! -d /vagrant/source ] && mkdir /vagrant/source
cd /vagrant/source
for l in $(cat /vagrant/repositories.txt)
do
    (
        repo=$(echo $l | cut -f 1 -d ':')
        dir=$(echo $l | cut -f 2 -d ':')
        if [ ! -d $dir ]; then
            git clone $repo $dir
        fi
    )
done

# Install packages
cat /vagrant/packages.txt | xargs sudo apt -y install
