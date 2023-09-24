SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.ONESHELL:

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe


# Remote VM. Replace LOCAL IP with remote VM IP
remote-ssh-login:
	source ./local/bash-helpers/helpers.sh
	ssh -i ./inventory/remote/.ssh/ansible-ubuntu "root@$$(Docker::getIP ansible-ubuntu-server-1)"

ping:
	ansible -m ping -i ./inventory/remote/remote.ini all
play-ping:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/ping.yml
play-base:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/base.yml
play-project-nginx:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/project/ssh.yml	
play-project-backend:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/project/backend.yml	
play-user:
	ansible-playbook -i ./inventory/remote/remote.ini playbooks/user.yml