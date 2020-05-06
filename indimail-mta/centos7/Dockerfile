FROM centos:7
MAINTAINER cprogrammer

# Freshen RUN yum update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& yum -y update \
	&& yum -y install \
		gnupg2 \
		binutils \
		hostname \
		less \
		cronie \
		man-db \
		net-tools \
		openssh-clients \
		openssl \
		procps \
		psmisc \
		systemd \
		telnet \
		vim \
		wget \
		which \
		strace \
		lsof \
		deltarpm \
	&& wget https://download.opensuse.org/repositories/home:mbhangui/CentOS_7/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo \
	&& wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm \
	&& rpm -ivh mysql80-community-release-el7-3.noarch.rpm \
	&& yum -y install indimail-mta mrtg \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
