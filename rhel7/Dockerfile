FROM rhel7
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN yum -y install wget openssl man-db vim net-tools gnupg2 procps systemd less telnet openssh-server
RUN wget https://download.opensuse.org/repositories/home:mbhangui/RHEL_7/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo
RUN printf "[mariadb]\nname = MariaDB\nbaseurl = http://yum.mariadb.org/10.2/centos7-amd64\ngpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\ngpgcheck=1\n" > /etc/yum.repos.d/mariadb.repo
RUN yum -y install indimail mariadb-server mariadb-libs mariadb-client
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
