SHELL := /bin/bash

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe

run-local-debian:
	./docker/debian11/build-debian.sh

run-local-ubuntu:
	./docker/ubuntu/build-start.sh

create-ansibe-user:
	./local/create-ansible-user.sh

create-local-inventory:
	./local/create-inventory.sh

ping-local:
	ansible -m ping -i inventory/local.ini all
play-ping-local:
	ansible-playbook -i inventory/local.ini playbook/ping.yml

play-setup-local:
	ansible-playbook -v -i inventory/local.ini playbook/system/setup.yml
play-add-user-local:
	ansible-playbook -i inventory/local.ini playbook/user/add-user.yml
play-firewall-local:
	ansible-playbook -i inventory/local.ini playbook/system/ufw.yml
play-extra-local:
	ansible-playbook -i inventory/local.ini playbook/extra/git-docker.yml
