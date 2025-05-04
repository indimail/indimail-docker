# docker build -f dockerfile.almalinux9 -t cprogrammer/indimail:almalinux9
FROM almalinux:9
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-docker/blob/master/indimail/almalinux9/Dockerfile
EXPOSE 25/tcp
EXPOSE 106/tcp
EXPOSE 209/tcp
EXPOSE 366/tcp
EXPOSE 465/tcp
EXPOSE 587/tcp
EXPOSE 110/tcp
EXPOSE 143/tcp
EXPOSE 993/tcp
EXPOSE 995/tcp
EXPOSE 3000/udp
EXPOSE 4000/tcp
EXPOSE 4110/tcp
EXPOSE 4143/tcp
EXPOSE 9110/tcp
EXPOSE 9143/tcp

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root \
	&& dnf -y install \
		'dnf-command(config-manager)' \
		https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
	&& dnf -y update \
	&& rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm \
	&& dnf -y install \
		gnupg2 \
		binutils \
		hostname \
		less \
		cronie \
		s-nail \
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
		perl-Authen-SASL \
		perl-Digest-HMAC \
		perl-Digest-SHA \
		perl-Net-SSLeay \
		passwd \
		mysql-community-server \
		mysql-community-client \
		mysql-community-libs \
	&& wget https://download.opensuse.org/repositories/home:mbhangui/AlmaLinux_9/home:mbhangui.repo -O /etc/yum.repos.d/indimail.repo \
	&& dnf -y install \
		indimail-mta \
		logalert \
		procmail \
		indimail \
		indimail-auth \
		indimail-access \
		indimail-utils \
		bogofilter-wordlist \
		indimail-spamfilter \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
	&& echo "Creating self signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
