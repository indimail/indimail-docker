# docker build -f dockerfile.rockylinux9 -t cprogrammer/indimail-mta:rockylinux9
FROM rockylinux:9
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-mta:rockylinux9

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& dnf -y install \
		'dnf-command(config-manager)' \
		https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
	&& dnf -y update \
	&& rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el8-4.noarch.rpm \
	&& dnf -y install \
		gnupg2 \
		binutils \
		hostname \
		less \
		cronie \
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
		s-nail \
		mysql-community-libs \
	&& wget https://download.opensuse.org/repositories/home:mbhangui/AlmaLinux_9/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo \
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