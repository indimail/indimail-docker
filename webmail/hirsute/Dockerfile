# docker build -f dockerfile.hirsute -t cprogrammer/indimail-web:hirsute
# run dpkg-reconfigure tzdata after starting the container
From ubuntu:hirsute
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:hirsute

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root/Downloads \
	&& sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
		/etc/dpkg/dpkg.cfg.d/excludes \
	&& apt-get -y update \
	&& apt-get -y install \
		curl wget gnupg2 apt-utils \
	&& (apt-get -y install mailutils || apt-get -y remove postfix cpio || exit 0) \
	&& curl -fsSL https://download.opensuse.org/repositories/home:mbhangui/xUbuntu_21.04/Release.key | \
		gpg --dearmor > /etc/apt/trusted.gpg.d/home_mbhangui.gpg \
	&& printf "deb http://download.opensuse.org/repositories/home:/mbhangui/xUbuntu_21.04/ /\n" > /etc/apt/sources.list.d/indimail.list \
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
		iwebadmin \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& apt-get -y install \
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
	&& a2enmod proxy_fcgi setenvif \
	&& a2enconf php7.4-fpm \
	&& systemctl enable apache2 \
	&& wget -nv \
		https://github.com/roundcube/roundcubemail/releases/download/1.4.11/roundcubemail-1.4.11-complete.tar.gz \
		-O /root/Downloads/roundcubemail.tar.gz \
	&& (cd /usr/share; \
		tar xfz /root/Downloads/roundcubemail.tar.gz; \
		mv roundcubemail/plugins/* roundcubemail-1.4.11/plugins; \
		/bin/rm -rf roundcubemail; \
		mv roundcubemail-1.4.11 roundcubemail; \
		chown -R root:root roundcubemail; \
		chown www-data:www-data roundcubemail/temp roundcubemail/logs; \
		cd roundcubemail; \
		chmod 775 logs temp; \
		mv config /etc/roundcubemail; \
		ln -s /etc/roundcubemail config; \
		systemctl disable mariadb; \
		systemctl stop mariadb; \
		/usr/libexec/indimail/roundcube_config; \
		/bin/rm -r /root/Downloads) >/tmp/roundcube.log 2>&1 \
	&& cat /tmp/roundcube.log \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
