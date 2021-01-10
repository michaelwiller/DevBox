#!/bin/bash

case $1 in

	start)
		vagrant up
		;;

	stop)
		vagrant halt
		;;
	
	reset)
		echo "Are you sure? This will delete the box and create it fresh!! Only 'yes' is considered approval:"
		read a
		[ ! $a == "yes" ] && exit 0
		$0 destroy
		$0 create
		;;
	
	destroy)
		vagrant destroy
		;;
	
	create)
		echo "Refresh ssh certificate"
		rm -f .ssh/id*
		cp ~/.ssh/id* .ssh/
		$0 start
		;;
	apply)
		echo Apply Ansible provisioning (missing)
		;;
	*)
		echo "usage: $0 start|stop|reset|destroy|create|apply"
esac
