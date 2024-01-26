# docker build -f dockerfile.almalinux9 -t cprogrammer/indimail-web:almalinux9
FROM almalinux:9
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-web:almalinux9

# Freshen RUN dnf update
RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root/Downloads \
	&& dnf -y install \
		'dnf-command(config-manager)' \
		https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
		https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
		https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm \
		dnf-utils \
	&& dnf -y module reset php \
	&& dnf -y module enable php:remi-8.1 \
	&& dnf -y update \
	&& dnf -y install \
		binutils \
		gnupg2 \
		hostname \
		less \
		cronie \
		s-nail \
		man-db \
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
		passwd \
		iputils \
		perl \
		perl-Authen-SASL \
		perl-Digest-HMAC \
		perl-Digest-SHA \
		perl-Net-SSLeay \
		mysql-community-server \
		mysql-community-libs \
		mysql-community-client \
	&& wget -nv \
		https://download.opensuse.org/repositories/home:mbhangui/AlmaLinux_9/home:mbhangui.repo \
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
	&& mkdir -p /var/log/build \
	&& (set -e; \
		systemctl enable httpd php-fpm; \
		wget -nv \
			https://github.com/roundcube/roundcubemail/releases/download/1.6.0/roundcubemail-1.6.0-complete.tar.gz \
			-O /root/Downloads/roundcubemail.tar.gz; \
		cd /usr/share; \
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
		/bin/rm -r /root/Downloads) >/var/log/build/roundcube.log 2>&1 \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
