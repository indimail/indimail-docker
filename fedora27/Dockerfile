FROM fedora:27
MAINTAINER cprogrammer

RUN dnf -y install wget openssl man-db vim net-tools procps less telnet openssh-server
RUN dnf -y install 'dnf-command(config-manager)'
RUN dnf config-manager --add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_27/home:mbhangui.repo
RUN dnf -y update
RUN dnf -y install indimail mrtg
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
