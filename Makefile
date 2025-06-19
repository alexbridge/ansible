SHELL := /bin/bash
FZF_DEFAULT_OPTS ?='--height 50% --layout=reverse --border --exact'

.ONESHELL:

YES := YES
USE_ANSIBLE_RUNNER := $(YES)
ANSIBLE_RUNNER_IMAGE := ansible-runner

# @$(call ansible_runner,make recipe)
define ansible_runner
	docker run --net=host --rm -it \
	-w /opt/ansible \
	-v .:/opt/ansible \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$$SSH_AUTH_SOCK:$$SSH_AUTH_SOCK" \
	-e SSH_AUTH_SOCK="$$SSH_AUTH_SOCK" \
	$(ANSIBLE_RUNNER_IMAGE) $1
endef

.DEFAULT:
_recipe-list:
	@recipe=$$(grep -oE '^[a-z][a-zA-Z0-9-]+:' Makefile | tr -d ':' | \
	fzf --preview 'make --silent -n {} | head -n 5' --preview-window=50%:down); \
	[[ -n "$$recipe" && "$(USE_ANSIBLE_RUNNER)" = "YES" ]] && $(call ansible_runner,make $$recipe)
	[[ -n "$$recipe" && "$(USE_ANSIBLE_RUNNER)" != "YES" ]] && make --silent $$recipe

_build-ansible-runner:
	docker build --tag $(ANSIBLE_RUNNER_IMAGE) .

# Remote VM. Replace LOCAL IP with remote VM IP
remote-ssh-login:
	source ./local/bash-helpers/helpers.sh
	ssh "root@$$(Docker::getIP ansible-ubuntu-server-1)"

INV_FILE := -i ./inventory/remote/remote.ini

ping:
	ansible -m ping $(INV_FILE)
play-ping:
	ansible-playbook $(INV_FILE) playbooks/ping.yml
play-base:
	ansible-playbook $(INV_FILE) playbooks/base.yml
play-project-nginx:
	ansible-playbook $(INV_FILE) playbooks/project/nginx.yml
play-project-ssh:
	ansible-playbook $(INV_FILE) playbooks/project/ssh.yml	
play-project-backend:
	ansible-playbook $(INV_FILE) playbooks/project/backend.yml	
play-user:
	ansible-playbook $(INV_FILE) playbooks/user.yml