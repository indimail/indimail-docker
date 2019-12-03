FROM centos:7
MAINTAINER cprogrammer

# Freshen RUN yum update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& yum -y update \
	&& yum -y install \
		gnupg2 \
		hostname \
		less \
		man-db \
		net-tools \
		openssh-server \
		openssl \
		procps \
		systemd \
		telnet \
		vim \
		wget \
		which \
		strace \
		lsof \
		deltarpm \
	&& wget https://download.opensuse.org/repositories/home:mbhangui/CentOS_7/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo \
	&& printf "[mariadb]\nname = MariaDB\nbaseurl = http://yum.mariadb.org/10.4/centos7-amd64\ngpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\ngpgcheck=1\n" > /etc/yum.repos.d/mariadb.repo \
	&& yum -y install indimail mrtg mariadb-server mariadb-libs mariadb-client iwebadmin \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
