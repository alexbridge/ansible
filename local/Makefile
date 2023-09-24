SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.ONESHELL:

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe


# Local Docker / Ubuntu
init-ubuntu:
	docker build --tag ansible-ubuntu/server:latest ./docker/ubuntu
	docker compose -f ./docker/ubuntu/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh

# Login to local
ssh-login-1:
	source ./bash-helpers/helpers.sh
	ssh  -i ./docker/ubuntu/.ssh/ansible-ubuntu "root@$$(Docker::getIP ansible-ubuntu-server-1)"
ssh-login-2:
	source ./bash-helpers/helpers.sh
	ssh  -i ./docker/ubuntu/.ssh/ansible-ubuntu "root@$$(Docker::getIP ansible-ubuntu-server-2)"
ssh-login-3:
	source ./bash-helpers/helpers.sh
	ssh  -i ./docker/ubuntu/.ssh/ansible-ubuntu "root@$$(Docker::getIP ansible-ubuntu-server-3)"
ssh-login-4:
	source ./bash-helpers/helpers.sh
	ssh  -i ./docker/ubuntu/.ssh/ansible-ubuntu "root@$$(Docker::getIP ansible-ubuntu-server-4)"

# Ansible recipes
check:
	ansible -m setup -i ./../inventory/local/local.ini all
ping:
	ansible -m ping -i ./../inventory/local/local.ini all
play-ping:
	ansible-playbook -i ./../inventory/local/local.ini ../playbooks/ping.yml
play-base:
	ansible-playbook -i ./../inventory/local/local.ini ../playbooks/base.yml
play-project-nginx:
	ansible-playbook -i ./../inventory/local/local.ini ../playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook -i ./../inventory/local/local.ini ../playbooks/project/ssh.yml
play-project-backend:
	ansible-playbook -i ./../inventory/local/local.ini ../playbooks/project/backend.yml
play-user:
	ansible-playbook -i ./../inventory/local/local.ini ./../playbooks/user.yml
