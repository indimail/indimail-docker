# docker build -f dockerfile.debian11 -t cprogrammer/indimail-web:debian11
FROM debian:11
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-docker/blob/master/almalinux9/debian11/Dockerfile
EXPOSE 25/tcp
EXPOSE 80/tcp
EXPOSE 106/tcp
EXPOSE 209/tcp
EXPOSE 366/tcp
EXPOSE 443/tcp
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

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root/Downloads \
	&& apt-get -y update \
	&& apt-get -y install \
		wget \
		gnupg2 \
		apt-utils \
	&& wget -nv https://download.opensuse.org/repositories/home:mbhangui/Debian_11/Release.key -O - | apt-key add - \
	&& printf "deb http://download.opensuse.org/repositories/home:/mbhangui/Debian_11/ /\n" > /etc/apt/sources.list.d/indimail.list  \
	&& printf "Package: *\nPin: origin download.opensuse.org\nPin-Priority: 1001\n"         > /etc/apt/preferences.d/preferences \
	&& apt-get -y update \
	&& apt-get -y install \
		debianutils \
		binutils \
		cron \
		curl \
		less \
		man-db \
		net-tools \
		openssl \
		openssh-client \
		procps \
		psmisc \
		systemd \
		systemd-sysv \
		telnet \
		strace \
		lsof \
		inetutils-ping \
		vim \
		mrtg \
		indimail \
		bogofilter-wordlist \
		indimail-mta \
		indimail-access \
		indimail-auth \
		indimail-utils \
		iwebadmin \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		libnet-ssleay-perl \
		libauthen-sasl-perl \
		libdigest-perl-md5-perl \
		libdigest-hmac-perl \
		gsasl \
	&& apt-get -y install \
		indimail-spamfilter \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& apt-get -y install \
		s-nail \
		apache2 \
		php \
		php-mysqlnd \
		php-mysql \
		php-fpm \
		libapache2-mod-php \
		php-curl \
		php-mbstring \
		php-xmlrpc \
		php-gd \
		php-xml \
		php-intl \
		php-imagick \
		php-json \
		php-zip \
		php-cli \
		ircube \
	&& update-alternatives --config mta \
	&& mkdir -p /var/log/build \
	&& (set -e; \
		a2enmod proxy_fcgi setenvif ssl; \
		a2enconf php7.4-fpm; \
		systemctl enable apache2; \
		wget -nv \
			https://github.com/roundcube/roundcubemail/releases/download/1.6.0/roundcubemail-1.6.0-complete.tar.gz \
			-O /root/Downloads/roundcubemail.tar.gz; \
		cd /usr/share; \
		tar xfz /root/Downloads/roundcubemail.tar.gz; \
		mv roundcubemail/plugins/* roundcubemail-1.6.0/plugins; \
		/bin/rm -rf roundcubemail; \
		mv roundcubemail-1.6.0 roundcubemail; \
		chown -R root:root roundcubemail; \
		chown www-data:www-data roundcubemail/temp roundcubemail/logs; \
		cd roundcubemail; \
		chmod 775 logs temp; \
		mv config /etc/roundcubemail; \
		ln -s /etc/roundcubemail config; \
		systemctl disable mariadb; \
		systemctl stop mariadb; \
		/usr/libexec/indimail/roundcube_config; \
		/bin/rm -r /root/Downloads) >/var/log/build/roundcube.log 2>&1 \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
