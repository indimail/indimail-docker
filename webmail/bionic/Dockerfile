# docker build -f dockerfile.bionic -t cprogrammer/indimail-web:bionic
# run dpkg-reconfigure tzdata after starting the container
# ubuntu 18.04
From ubuntu:bionic
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:bionic

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root/Downloads \
	&& sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
		/etc/dpkg/dpkg.cfg.d/excludes \
	&& apt-get -y update \
	&& apt-get -y install wget gnupg2 apt-utils coreutils \
	&& (apt-get -y install mailutils || exit 0) \
	&& wget -nv https://download.opensuse.org/repositories/home:mbhangui/xUbuntu_18.04/Release.key -O - | apt-key add - \
	&& printf "deb http://download.opensuse.org/repositories/home:/mbhangui/xUbuntu_18.04/ /\n" > /etc/apt/sources.list.d/indimail.list \
	&& printf "Package: *\nPin: origin download.opensuse.org\nPin-Priority: 1001\n"             > /etc/apt/preferences.d/preferences \
	&& apt-get -y update \
	&& apt-get -y install \
		debianutils \
		binutils \
		cron \
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
		vim \
		mrtg \
		indimail \
		indimail-mta \
		indimail-access \
		indimail-auth \
		indimail-utils \
		indimail-spamfilter \
		bogofilter-wordlist \
		iwebadmin \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& apt-get -y install \
		mailutils libgsasl7 \
		apache2 \
		php \
		php-mysql \
		php-mysqlnd \
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
		a2enmod proxy_fcgi setenvif; \
		a2enconf php7.2-fpm; \
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
		systemctl disable postfix; \
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
