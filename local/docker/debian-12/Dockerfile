ARG DEBIAN_VERSION
ARG DEBIAN_IMAGE=debian:${DEBIAN_VERSION}

FROM ${DEBIAN_IMAGE}

EXPOSE 22

USER root

RUN apt-get update && apt-get install -y openssh-server sudo gpg cron python3


RUN echo 'root:root' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

RUN mkdir /var/run/sshd 

CMD ["/usr/sbin/sshd", "-E", "/var/log/ssh.log", "-D"]
