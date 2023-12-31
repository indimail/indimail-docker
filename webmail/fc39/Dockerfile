# docker build -f dockerfile.fc39 -t cprogrammer/indimail-web:fc39
FROM fedora:39
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-web:fc39

RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
	&& dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager \
		--add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_39/home:mbhangui.repo \
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
		passwd \
		iputils \
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
		perl-Authen-SASL \
		perl-Digest-HMAC \
		perl-Digest-SHA \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org \
		--common_name=indimail.org > /dev/null 2>/tmp/cert.log || \
		echo "certificate generation failed" \
	&& mkdir -p /var/log/build \
	&& /usr/libexec/indimail/roundcube_config > /var/log/build/roundcube.log 2>&1 \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
