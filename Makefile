SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe


# Remote VM. Replace 172.17.0.2 with remote VM IP
remote-ssh-login:
	ssh -i ./inventory/.ssh/ansible-ubuntu root@172.17.0.2

ping:
	ansible -m ping -i ./inventory/remote.ini all
play-ping:
	ansible-playbook -i ./inventory/remote.ini playbooks/ping.yml
play-base:
	ansible-playbook -i ./inventory/remote.ini playbooks/base.yml
play-project-nginx:
	ansible-playbook -i ./inventory/remote.ini playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook -i ./inventory/remote.ini playbooks/project/ssh.yml	
play-project-backend:
	ansible-playbook -i ./inventory/remote.ini playbooks/project/backend.yml	
play-user:
	ansible-playbook -i ./inventory/remote.ini playbooks/user.yml