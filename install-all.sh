#! /usr/bin/env bash

cd $HOME

# Clone default repositories
[ ! -d /vagrant/source ] && mkdir /vagrant/source
cd /vagrant/source
for l in $(cat /vagrant/repositories.txt)
do
    (
        dir=$(echo $l | cut -f 1 -d '#')
        repo=$(echo $l | cut -f 2 -d '#')
        if [ ! -d $dir ]; then
            git clone $repo $dir
        fi
    )
done

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# Install packages
cat /vagrant/packages.txt | xargs sudo apt -y install
