FROM opensuse:42.2
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN zypper -y install wget openssl man-db vim net-tools gnupg2 procps systemd less telnet openssh-server which systemd-sysvinit hostname
RUN zypper addrepo https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_42.2/home:mbhangui.repo
RUN zypper addrepo https://download.opensuse.org/repositories/server:database/openSUSE_Leap_42.2/server:database.repo
RUN hostname indimail.org
RUN zypper -y refresh
RUN zypper -y install indimail libmysqlclient18
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
