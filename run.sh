#!/bin/bash

case $1 in

	start)
		echo vagrant up
		;;

	stop)
		echo vagrant halt
		;;
	
	reset)
		echo "Are you sure? This will delete the box and create it fresh!! Only 'yes' is considered approval:"
		read a
		[ ! $a == "yes" ] && exit 0
		$0 destroy
		$0 create
		;;
	
	destroy)
		echo vagrant destroy
		;;
	
	create)
		echo "Refresh ssh certificate"
		rm -f .ssh/id*
		cp ~/.ssh/id* .ssh/
		echo vagrant up
		;;
	apply)
		echo Apply Ansible provisioning
		;;
	*)
		echo "usage: $0 start|stop|reset|destroy|create|apply"
esac
