FROM opensuse:42.3
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN zypper --non-interactive install wget openssl vim net-tools procps systemd less telnet openssh which systemd-sysvinit sudo patch
RUN zypper --non-interactive addrepo https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_42.3/home:mbhangui.repo
RUN zypper --non-interactive addrepo https://download.opensuse.org/repositories/server:database/openSUSE_Leap_42.3/server:database.repo
RUN zypper --non-interactive --gpg-auto-import-keys refresh
RUN zypper --non-interactive --gpg-auto-import-keys install indimail libmysqlclient18 mysql-community-server
RUN wget -nv https://raw.githubusercontent.com/mbhangui/docker/master/indimail/leap42.3/mysql_install_db.patch -O /tmp/mysql_install_db.patch
RUN patch -p0 < /tmp/mysql_install_db.patch
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
