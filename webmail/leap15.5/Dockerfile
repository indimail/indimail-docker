# docker build -f dockerfile.leap15.5 -t cprogrammer/indimail-web:leap15.5
FROM opensuse/leap:15.5
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-web:leap15.5

RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root \
	&& sed -i 's{rpm.install.exclude.*=.*{rpm.install.exclude = no{' /etc/zypp/zypp.conf \
	&& zypper --non-interactive update \
	&& zypper --non-interactive install \
		wget \
		man-pages \
		binutils \
		openssl \
		vim \
		net-tools \
		procps \
		psmisc \
		systemd \
		less \
		telnet \
		openssh \
		which \
		systemd-sysvinit \
		sudo \
		strace \
		lsof \
		iputils \
		cron \
		gzip \
		curl \
		glibc-locale-base \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_15.5/home:mbhangui.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/15.5/server:database.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:monitoring/15.5/server:monitoring.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:php:applications/15.5/server:php:applications.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& sed -i -e 's{rpm.install.excludedocs = yes{rpm.install.excludedocs = no{' /etc/zypp/zypp.conf \
	&& zypper --non-interactive --gpg-auto-import-keys install \
		indimail \
		indimail-mta \
		indimail-access \
		indimail-auth \
		indimail-utils \
		bogofilter-wordlist \
		indimail-spamfilter \
		mrtg \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
		ircube \
		apache2-mod_php7 \
		php7-ctype \
		php7-curl \
		php7-exif \
		php7-fileinfo \
		php7-gd \
		php7-imagick \
		php7-intl \
		php-xmlwriter \
		php7-xmlrpc \
		php7-zip \
		roundcubemail \
		mailx \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& mkdir -p /var/log/build \
	&& (cp -rp /usr/share/roundcubemail/plugins/* /srv/www/roundcubemail/plugins; \
		systemctl disable sshd mariadb; \
		a2enmod php7; \
		sed -e 's{^${LoadModule php7_module /usr/lib64/apache2-prefork/mod_php7.so{' /etc/apache2/loadmodule.conf; \
		/usr/libexec/indimail/roundcube_config) >/var/log/build/roundcube.log 2>&1 \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
