FROM alpine:3.19.1

WORKDIR /opt/ansible

RUN apk --no-cache add \
    openssl  \
    sshpass \
    openssh  \
    bash \
    make \
    python3\
    py3-pip \
    ansible-core

# To allow pip install
RUN rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED

RUN pip install requests

RUN ansible-galaxy collection install ansible.posix
RUN ansible-galaxy collection install community.general
RUN ansible-galaxy collection install community.docker
RUN ansible-galaxy collection install community.crypto

# Enable to build Standalone Image
# COPY . .