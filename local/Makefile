SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.ONESHELL:

YES := YES
USE_ANSIBLE_RUNNER := $(YES)
ANSIBLE_RUNNER_IMAGE := ansible-runner

# @$(call ansible_runner,make recipe)
define ansible_runner
	docker run --net=host --rm -it \
	-w /opt/ansible/local \
	-v ./..:/opt/ansible \
	-v /var/run/docker.sock:/var/run/docker.sock \
	$(ANSIBLE_RUNNER_IMAGE) $1
endef

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" && "$(USE_ANSIBLE_RUNNER)" == "YES" ]] && $(call ansible_runner,make $$recipe)
	[[ -n "$$recipe" && "$(USE_ANSIBLE_RUNNER)" != "YES" ]] && make --silent $$recipe

_exec-ansible-runner:
	$(call ansible_runner,bash)

# === UBUNTU Local
_init-ubuntu:
	docker build --tag ansible-ubuntu/server:latest -f ./docker/ubuntu/Dockerfile .
	docker compose -f ./docker/ubuntu/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh
_stop-ubuntu:
	docker compose -f ./docker/ubuntu/docker-compose.yml down --volumes

# === DEBIAN 11
_init-debian:
	docker build --tag ansible-debian/server:latest -f ./docker/debian-11/Dockerfile .
	docker compose -f ./docker/debian-11/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh
_stop-debian:
	docker compose -f ./docker/debian-11/docker-compose.yml down --volumes

# === DEBIAN 12
_init-debian-12:
	docker build --tag ansible-debian12/server:latest -f ./docker/debian-12/Dockerfile .
	docker compose -f ./docker/debian-12/docker-compose.yml up --detach --force-recreate
	./create-inventory.sh
_stop-debian-12:
	docker compose -f ./docker/debian-12/docker-compose.yml down --volumes

# Login to local
ANSIBLE_ID := -i ./.ssh/ansible-id
_ssh-login-1:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "ansible@$$(Docker::getIP ansible-server-1)"
_ssh-login-2:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-2)"
_ssh-login-3:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-3)"
_ssh-login-4:
	source ./bash-helpers/helpers.sh
	ssh  $(ANSIBLE_ID) "root@$$(Docker::getIP ansible-server-4)"

# Ansible recipes
INV_LOCAL := -i ./../inventory/local/local.ini
setup:
	ansible -m setup $(INV_LOCAL) all
ping:
	ansible -m ping $(INV_LOCAL) all
play-echo:
	ansible-playbook -vv $(INV_LOCAL) ../playbooks/echo.yml
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
