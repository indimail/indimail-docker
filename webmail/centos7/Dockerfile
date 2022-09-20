# docker build -f dockerfile.centos7 -t cprogrammer/indimail-web:centos7
FROM centos:7
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:centos7

# Freshen RUN yum update
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root/Downloads \
	&& yum -y install \
		epel-release \
		http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
		https://dev.mysql.com/get/mysql80-community-release-el7-7.noarch.rpm \
		yum-utils \
		deltarpm \
	&& yum-config-manager --enable remi-php74 \
	&& yum -y update \
	&& yum -y install \
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
		https://download.opensuse.org/repositories/home:mbhangui/CentOS_7/home:mbhangui.repo \
		-O /etc/yum.repos.d/indimail.repo \
	&& yum -y install \
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
		https://github.com/roundcube/roundcubemail/releases/download/1.6.0/roundcubemail-1.6.0-complete.tar.gz \
		-O /root/Downloads/roundcubemail.tar.gz \
	&& (sed -i \
			-e 's}listen = 127.0.0.1:9000}listen = /run/php-fpm/www.sock}' \
			-e 's};listen.owner = nobody}listen.owner = apache}g' \
			-e 's};listen.group = nobody}listen.group = apache}g' \
			-e 's};listen.mode = 0660}listen.mode = 0660}g' \
			-e 's}^listen.acl_users.};&}' /etc/php-fpm.d/www.conf) \
	&& (cd /usr/share; \
		tar xfz /root/Downloads/roundcubemail.tar.gz; \
		mv roundcubemail/plugins/* roundcubemail-1.6.0/plugins; \
		/bin/rm -rf roundcubemail; \
		mv roundcubemail-1.6.0 roundcubemail; \
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
