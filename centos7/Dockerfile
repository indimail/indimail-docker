FROM centos:7
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN yum -y install wget openssl man-db vim net-tools gnupg2 procps systemd less telnet openssh-server
RUN wget https://download.opensuse.org/repositories/home:mbhangui/CentOS_CentOS-7/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo
RUN yum -y install indimail
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
