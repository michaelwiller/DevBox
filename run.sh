#!/bin/bash

case $1 in

	start)
		echo "Start"
		vagrant up
		;;

	stop)
		echo "Halt"
		vagrant halt
		;;
	restart)
		echo "Restart"
		$0 stop
		$0 start
	        ;;
	reset)
		echo "Reset"
		echo "Are you sure? This will delete the box and create it fresh!! Only 'yes' is considered approval:"
		read a
		[ ! $a == "yes" ] && exit 0
		$0 destroy
		$0 create
		;;
	
	destroy)
		echo "Destroy"
		vagrant destroy -f
		;;
	
	create)
		echo "Refresh ssh certificate"
		rm -f .ssh/id*
		cp ~/.ssh/id* .ssh/
		$0 start
		sleep 30
		;;
	apply)
		shift
		prov=$*
		[ -z $2 ] && prov=run-all.yml
		echo "Reset secrets"
		echo "---" >> $$.yml
		echo "values:" >> $$.yml
		echo "  myval: true" >> $$.yml
		vagrant ssh -c "sudo cp /vagrant/$$.yml /var/ansible-secrets"
		echo "Apply Ansible provisioning $prov"
		for a in $prov; do
		  b=$(basename $a)
		  echo "Apply $b"
                  vagrant ssh -c "cd /vagrant/ansible && ansible-playbook $b"
                done
		;;
	*)
		echo "usage: $0 start|stop|reset|destroy|create|apply"
esac
