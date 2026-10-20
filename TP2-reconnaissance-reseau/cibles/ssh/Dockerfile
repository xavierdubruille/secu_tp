# Cible SSH du segment exposé d'ACME — OpenSSH "cuit" dans l'image.
# Dérivé de la cible ssh-target de borck (week4), mais openssh est installé AU
# BUILD (pas d'`apt-get` au démarrage) : une fois construite, la cible démarre sans réseau.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && ssh-keygen -A \
    && useradd -m -s /bin/bash guest \
    && echo 'guest:guest123' | chpasswd \
    && sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
