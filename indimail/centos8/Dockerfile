FROM centos:8
MAINTAINER cprogrammer

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& dnf -y update \
	&& dnf -y install 'dnf-command(config-manager)' \
		drpm \
	&& dnf config-manager --set-enabled PowerTools \
	&& dnf -y module disable mysql \
	&& rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm \
	&& dnf -y install \
		gnupg2 \
		hostname \
		less \
		man-db \
		net-tools \
		openssh-server \
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
		mysql-community-server \
		mysql-community-client \
		mysql-community-libs \
	&& dnf -y install \
		http://downloads.sourceforge.net/indimail/Repo/CentOS8/indimail-mta-2.10-1.1.el8.x86_64.rpm \
		http://downloads.sourceforge.net/indimail/Repo/CentOS8/libqmail-0.1-1.el8.x86_64.rpm \
		http://downloads.sourceforge.net/indimail/Repo/CentOS8/indimail-3.0-1.1.el8.x86_64.rpm \
		http://downloads.sourceforge.net/indimail/Repo/CentOS8/iwebadmin-2.0-1.1.el8.x86_64.rpm \
		mrtg \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
