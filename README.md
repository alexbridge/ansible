### Ansible playbooks for base VM setup

#### Live example

![Live Example](./usage.gif)

#### Ansible

Ansible playbook run inside docker container `ansible-runner`, with installed ansible 
packages and galaxy collections.

1. Build ansible runner first before running playbooks
2. Run `make _build-ansible-runner`: this will created image with ansible inside.

#### Local testing of playbooks with Ubuntu

- inside `local` directory
- `make _init-ubuntu` : this will create 4 local ubuntu VMs and local inventory file

Check [local Makefile](./local/Makefile) recipes for local playbook commands

Base VM setup Playbooks:

- `make ping`: to check if connection works
- `make play-ping`: run roles/base/ping to check group/hosts vars, facts, etc
- `make play-base`: basic VM setup (packages): git, docker, etc.

Project specific VM setup Playbooks:
- `make play-project-nginx`: install nginx and add project hosts
- `make play-project-backend`: deploy project backend
- `make play-project-ssh`: add SSH authorized keys

#### Local testing of playbooks with Debian 12

- inside `local` directory
- `make _init-debian-12` : this will create 4 local Debian 12 VMs and local inventory file

Check [local Makefile](./local/Makefile) recipes for local playbook commands

Base VM setup Playbooks:

- `make ping`: to check if connection works
- `make play-ping`: run roles/base/ping to check group/hosts vars, facts, etc
- `make play-base`: basic VM setup (packages): git, docker, etc.

Project specific VM setup Playbooks:
- `make play-project-nginx`: install nginx and add project hosts
- `make play-project-backend`: deploy project backend
- `make play-project-ssh`: add SSH authorized keys


#### Execute playbooks on remote host

Update [./inventory/remote/remote.ini](./inventory/remote/remote.ini)  

- add remote VM IP address and other configs (if needed)

Run Playbooks
- check [Makefile](./Makefile) recipes for playbook commands

