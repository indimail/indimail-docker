# docker build -f dockerfile.stream8 -t cprogrammer/indimail-web:stream8
FROM quay.io/centos/centos:stream8 
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:stream8

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root/Downloads \
	&& dnf -y install \
		'dnf-command(config-manager)' \
		epel-release \
		https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
		https://dev.mysql.com/get/mysql80-community-release-el8-4.noarch.rpm \
		dnf-utils \
		drpm \
	&& dnf -y module reset php \
	&& dnf -y module enable php:remi-7.4 \
	&& dnf -y module disable mysql \
	&& dnf -y update \
	&& dnf config-manager --set-enabled powertools \
	&& dnf -y install \
		binutils \
		gnupg2 \
		hostname \
		less \
		cronie \
		mailx \
		man-db \
		man-pages \
		mrtg \
		net-tools \
		openssl \
		openssh-clients \
		procps \
		psmisc \
		rsync \
		systemd \
		telnet \
		vim \
		wget \
		which \
		strace \
		lsof \
		perl \
		mysql-community-server \
		mysql-community-libs \
		mysql-community-client \
	&& wget -nv \
		https://download.opensuse.org/repositories/home:mbhangui/CentOS-8_Stream/home:mbhangui.repo \
		-O /etc/yum.repos.d/indimail.repo \
	&& dnf -y install \
		indimail \
		indimail-mta \
		indimail-access \
		indimail-auth \
		indimail-utils \
		indimail-spamfilter \
		bogofilter-wordlist \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
		httpd \
		mod_ssl \
		php \
		php-fpm \
		php-mysqlnd \
		php-imagick \
		php-mcrypt \
		php-mbstring \
		php-xml \
		php-xmlrpc \
		php-gd \
		php-intl \
		php-json \
		php-zip \
		php-cli \
		ircube \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& systemctl enable httpd php-fpm \
	&& wget -nv \
		https://github.com/roundcube/roundcubemail/releases/download/1.4.11/roundcubemail-1.4.11-complete.tar.gz \
		-O /root/Downloads/roundcubemail.tar.gz \
	&& (cd /usr/share; \
		tar xfz /root/Downloads/roundcubemail.tar.gz; \
		mv roundcubemail/plugins/* roundcubemail-1.4.11/plugins; \
		/bin/rm -rf roundcubemail; \
		mv roundcubemail-1.4.11 roundcubemail; \
		chown -R root:root roundcubemail; \
		chown apache:apache roundcubemail/temp roundcubemail/logs; \
		chmod 775 roundcubemail/temp roundcubemail/logs; \
		mv roundcubemail/config /etc/roundcubemail; \
		ln -s /etc/roundcubemail /usr/share/roundcubemail/config; \
		systemctl disable mysqld 2>/dev/null; \
		/usr/libexec/indimail/roundcube_config; \
		/bin/rm -r /root/Downloads) >/tmp/roundcube.log 2>&1 \
	&& cat /tmp/roundcube.log \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
