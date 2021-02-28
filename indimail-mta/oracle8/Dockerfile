# docker build -f dockerfile.centos8 -t cprogrammer/indimail-mta:centos8
FROM oraclelinux:8
MAINTAINER cprogrammer

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& dnf -y install 'dnf-command(config-manager)' \
		drpm \
	&& dnf -y update \
	&& dnf -y module disable mysql \
	&& rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm \
	&& dnf -y install \
		gnupg2 \
		binutils \
		hostname \
		less \
		cronie \
		mailx \
		man-db \
		net-tools \
		openssl \
		openssh-clients \
		procps \
		psmisc \
		systemd \
		telnet \
		vim \
		wget \
		which \
		strace \
		lsof \
		perl \
		mysql-community-libs \
	&& wget https://download.opensuse.org/repositories/home:mbhangui/CentOS_8/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo \
	&& dnf -y install \
		indimail-mta \
		logalert \
		procmail \
		indimail-auth \
		indimail-access \
		indimail-utils \
		bogofilter-wordlist \
		indimail-spamfilter \
	&& echo "Creating self signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
