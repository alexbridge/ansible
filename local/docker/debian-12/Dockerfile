FROM debian:12-slim

EXPOSE 22

USER root

RUN apt-get update && apt-get install -y openssh-server sudo gpg cron python3

# RUN echo 'root:root' | chpasswd
# RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'AuthorizedKeysFile .ssh/authorized_keys' >> /etc/ssh/sshd_config
# RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN echo 'UsePAM no' >> /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh
COPY .ssh/ansible-id.pub /root/.ssh/authorized_keys

RUN mkdir /var/run/sshd 

CMD ["/usr/sbin/sshd", "-E", "/var/log/ssh.log", "-D"]
