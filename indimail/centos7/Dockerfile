FROM centos:7
MAINTAINER cprogrammer

# Freshen RUN yum update
COPY docker-entrypoint.sh /usr/bin/
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
	&& wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm \
	&& rpm -ivh mysql80-community-release-el7-3.noarch.rpm \
	&& yum -y install indimail mrtg mysql-community-server mysql-community-libs mysql-community-client iwebadmin \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& chmod 755 /usr/bin/docker-entrypoint.sh \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["indimail"]
