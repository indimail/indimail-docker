# docker build -f dockerfile.leap15.4 -t cprogrammer/indimail-web:leap15.4
FROM opensuse/leap:15.4
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:leap15.4

RUN export HOSTNAME=indimail.org \
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
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_15.4/home:mbhangui.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/15.4/server:database.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:monitoring/15.4/server:monitoring.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:php:applications/openSUSE_Leap_15.4/server:php:applications.repo \
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
