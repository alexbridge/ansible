FROM ubuntu:18.04

EXPOSE 22

USER root

RUN apt-get update && apt-get install -y openssh-server sudo gpg cron

RUN echo 'root:root' | chpasswd

RUN mkdir /var/run/sshd 
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-E", "/var/log/ssh.log", "-D"]
