### Ansible playbooks for base VM setup

#### Local testing of playbooks

First create and run ***Ubuntu*** Docker container

- `make run-local-ubuntu`

Second, create local inventory: it will read Ubuntu IP address

- `make create-local-inventory`

Run Playbooks:

- `make ping-local`: to check is Ubuntu Container availabe
- `make play-setup-local`: basic packages setup
- `make play-add-user-local`: add use SSH key to Ubuntu for passwordless logins
- `make play-extra-local`: install git, Docker

#### Execute playbooks on remote host

Create inventory for remote host.  
- Check [remote.ini](/inventory/remote.ini) file for details.

Run Playbooks
- check [Makefile](./Makefile) recipes for playbook commands

#### Live example

![Live Example](./usage.gif)