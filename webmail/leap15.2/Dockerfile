# docker build -f dockerfile.leap15.2 -t cprogrammer/indimail-web:leap15.2
FROM opensuse/leap:15.2
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:leap15.2

RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& zypper --non-interactive update \
	&& zypper --non-interactive install \
		wget \
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
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_15.2/home:mbhangui.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/openSUSE_Leap_15.2/server:database.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:monitoring/openSUSE_Leap_15.2/server:monitoring.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:php:applications/openSUSE_Leap_15.2/server:php:applications.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& sed -i -e 's{rpm.install.excludedocs = yes{rpm.install.excludedocs = no{' /etc/zypp/zypp.conf \
	&& zypper --non-interactive --gpg-auto-import-keys install \
		indimail \
		mrtg \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
		ircube \
		apache2-mod_php7 \
		php7-ctype \
		php7-gd \
		php7-imagick \
		php7-intl \
		php7-xmlrpc \
		php7-zip \
		roundcubemail \
		mailx \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& (cp -rp /usr/share/roundcubemail/plugins/* /srv/www/roundcubemail/plugins; \
		systemctl disable sshd; systemctl disable mysqld; \
		a2enmod php7; \
		sed -e 's{^${LoadModule php7_module /usr/lib64/apache2-prefork/mod_php7.so{' /etc/apache2/loadmodule.conf; \
		/usr/libexec/indimail/roundcube_config) >/tmp/roundcube.log 2>&1 \
	&& cat /tmp/roundcube.log \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
#	&& wget -nv \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/001-fix-roundcube-httpd-conf.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/002-fix-db.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/003-fix-plugins.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/004-fix-php-ini.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/005-fix-roundcubemail-config-php.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/006-fix-ssl-conf.sh \
#		https://raw.githubusercontent.com/mbhangui/docker/master/webmail/leap15.2/007-misc.sh \
#&& (for i in 00*; do sh $i; done; ) > /tmp/roundcube.com 2>&1 \
