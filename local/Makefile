SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe


# Local Docker / Ubuntu
init-ubuntu:
	./docker/ubuntu/build-start.sh
	./create-inventory.sh

# Login to local ansible-ubuntu via ssh
local-ssh-login:
	ssh  -i ./docker/ubuntu/.ssh/ansible-ubuntu" "root@$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ansible-ubuntu)"

# Ansible recipes
check:
	ansible -m setup -i ./inventory.ini all
ping:
	ansible -m ping -i ./inventory.ini all
play-ping:
	ansible-playbook -i ./inventory.ini ../playbooks/ping.yml
play-base:
	ansible-playbook -i ./inventory.ini ../playbooks/base.yml
play-project-nginx:
	ansible-playbook -i ./inventory.ini ../playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook -i ./inventory.ini ../playbooks/project/ssh.yml
play-project-backend:
	ansible-playbook -i ./inventory.ini ../playbooks/project/backend.yml
play-user:
	ansible-playbook -i ./inventory.ini ./../playbooks/user.yml
