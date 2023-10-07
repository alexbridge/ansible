SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.ONESHELL:

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" ]] && make --silent $$recipe


# === UBUNTU Local
init-ubuntu:
	docker build --tag ansible-ubuntu/server:latest -f ./docker/ubuntu/Dockerfile .
	docker compose -f ./docker/ubuntu/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh
stop-ubuntu:
	docker compose -f ./docker/ubuntu/docker-compose.yml down --volumes

# === DEBIAN Local
init-debian:
	docker build --tag ansible-debian/server:latest -f ./docker/debian-11/Dockerfile .
	docker compose -f ./docker/debian-11/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh
stop-debian:
	docker compose -f ./docker/debian-11/docker-compose.yml down --volumes

# Login to local
ANSIBLE_ID := -i ./.ssh/ansible-id
ssh-login-1:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-1)"
ssh-login-2:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-2)"
ssh-login-3:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-3)"
ssh-login-4:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-4)"

# Ansible recipes
INV_LOCAL := -i ./../inventory/local/local.ini
check:
	ansible -m setup $(INV_LOCAL) all
ping:
	ansible -m ping $(INV_LOCAL) all
play-ping:
	ansible-playbook $(INV_LOCAL) ../playbooks/ping.yml
play-base:
	ansible-playbook $(INV_LOCAL) ../playbooks/base.yml
play-project-nginx:
	ansible-playbook $(INV_LOCAL) ../playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook $(INV_LOCAL) ../playbooks/project/ssh.yml
play-project-backend:
	ansible-playbook $(INV_LOCAL) ../playbooks/project/backend.yml
play-user:
	ansible-playbook $(INV_LOCAL) ./../playbooks/user.yml
