# docker build -f dockerfile.fc32 -t cprogrammer/indimail:fc32
FROM fedora:32
MAINTAINER cprogrammer

RUN dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager \
		--add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_32/home:mbhangui.repo
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& dnf -y update \
	&& dnf -y install \
		binutils \
		gnupg2 \
		hostname \
		initscripts \
		less \
		cronie \
		mailx \
		man-db \
		mrtg \
		net-tools \
		openssh-clients \
		openssl \
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
		deltarpm \
		indimail \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
		httpd \
		mod_ssl \
		roundcubemail \
		php-mysqlnd \
		php-imagick \
		ircube \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& (sed -i \
			-e 's};listen.owner = nobody}listen.owner = apache}g' \
			-e 's};listen.group = nobody}listen.group = apache}g' \
			-e 's};listen.mode = 0660}listen.mode = 0660}g' \
			-e 's}^listen.acl_users.};&}' /etc/php-fpm.d/www.conf; \
		mkdir -p /service/httpd; \
		(echo "#!/bin/sh"; echo "exec /usr/sbin/httpd -DFOREGROUND") \
			> /service/httpd/run; \
		chmod 755 /service/httpd/run; \
		mkdir -p /service/.fpm-php/log; \
		(echo "#!/bin/sh"; echo "mkdir -p /var/run/php-fpm"; echo "exec /usr/sbin/php-fpm -O -F") \
			> /service/.fpm-php/run; \
		chmod 755 /service/.fpm-php/run; \
		(echo "#!/bin/sh"; echo "exec /usr/bin/setuidgid qmaill \\" echo "  /usr/sbin/multilog t /var/log/svc/php-fpm") \
			> /service/.fpm-php/log/run; \
		chmod 755 /service/.fpm-php/log/run) \
	&& /usr/libexec/indimail/roundcube_config > /tmp/roundcube.log 2>&1 \
	&& cat /tmp/roundcube.log \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
