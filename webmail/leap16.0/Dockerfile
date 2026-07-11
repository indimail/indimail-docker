# docker build -f dockerfile.leap16.0 -t cprogrammer/indimail-web:leap16.0
FROM opensuse/leap:16.0
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-docker/blob/master/almalinux9/leap16.0/Dockerfile
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

RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root \
	&& echo "rpm.install.exclude = no" > /etc/zypp/zypp.conf.d/zypp_rpm.conf \
	&& echo "rpm.install.excludedocs = no" > /etc/zypp/zypp.conf.d/zypp_docs.conf \
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
		sudo \
		strace \
		lsof \
		iputils \
		cron \
		gzip \
		curl \
		glibc-locale-base \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_16.0/home:mbhangui.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/16.0/server:database.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:monitoring/16.0/server:monitoring.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:php:applications/16.0/server:php:applications.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& zypper --non-interactive --gpg-auto-import-keys install mariadb \
	&& /bin/rm -f /etc/my.cnf \
	&& ln -sf /etc/indimail/indimail.cnf /etc/my.cnf \
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
		apache2-mod_php8 \
		php8-ctype \
		php8-curl \
		php8-exif \
		php8-fileinfo \
		php8-gd \
		php8-imagick \
		php8-intl \
		php8-zip \
		php-fpm \
		roundcubemail \
		mailx \
	&& ls -d /var/indimail/mysqldb/data/indimail /var/indimail/mysqldb/data/ /var/indimail/mysqldb/data/mysql >/dev/null \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& mkdir -p /var/log/build \
	&& (cp -rp /usr/share/roundcubemail/plugins/* /srv/www/roundcubemail/plugins; \
		systemctl disable sshd mariadb; \
		a2enmod php8; \
		sed -i -e 's{^${LoadModule php8_module /usr/lib64/apache2-prefork/mod_php8.so{' /etc/apache2/loadmodule.conf; \
		/usr/libexec/indimail/roundcube_config) >/var/log/build/roundcube.log 2>&1 \
	&& ls -d /var/indimail/mysqldb/data/RoundCube_db >/dev/null \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
