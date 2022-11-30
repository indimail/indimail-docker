# docker build -f dockerfile.fc37 -t cprogrammer/indimail-web:fc37
FROM fedora:37
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:fc37

RUN export HOSTNAME=indimail.org \
	&& sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
	&& dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager \
		--add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_37/home:mbhangui.repo \
	&& mkdir -p /root/Downloads \
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
		man-pages \
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
		roundcubemail \
		php-mysqlnd \
		php-imagick \
		ircube \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org \
		--common_name=indimail.org > /dev/null 2>/tmp/cert.log || \
		echo "certificate generation failed" \
	&& echo "Created self-signed certificate" \
	&& sed -i \
			-e 's};listen.owner = nobody}listen.owner = apache}g' \
			-e 's};listen.group = nobody}listen.group = apache}g' \
			-e 's};listen.mode = 0660}listen.mode = 0660}g' \
			-e 's}^listen.acl_users.};&}' /etc/php-fpm.d/www.conf \
	&& /usr/libexec/indimail/roundcube_config > /tmp/roundcube.log 2>&1 \
	&& cat /tmp/roundcube.log \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
