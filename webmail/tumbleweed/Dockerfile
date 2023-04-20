# docker build -f dockerfile.tumbleweed -t cprogrammer/indimail-web:tumbleweed
FROM opensuse/tumbleweed
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-web:tumbleweed

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
		cron \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Tumbleweed/home:mbhangui.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/openSUSE_Tumbleweed/server:database.repo \
	&& zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:monitoring/openSUSE_Tumbleweed/server:monitoring.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& sed -i -e 's{rpm.install.excludedocs = yes{rpm.install.excludedocs = no{' /etc/zypp/zypp.conf \
	&& zypper --non-interactive --gpg-auto-import-keys install \
		indimail \
		indimail-mta \
		indimail-access \
		indimail-auth \
		indimail-utils \
		indimail-spamfilter \
		bogofilter-wordlist \
		mrtg \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
		ircube \
		roundcubemail \
		mailx \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& mkdir -p /var/log/build \
	&& systemctl disable sshd mariadb \
	&& /usr/libexec/indimail/roundcube_config >/var/log/build/roundcube.log 2>&1 \
	&& (echo "Build Succeeded" && gzip /var/log/build/roundcube.log) || (echo "Build Failed" && cat /var/log/build/roundcube.log && exit 1) \
	&& (test -d /var/indimail/mysqldb/data/RoundCube_db && echo "RoundCube db creation succeeded") || \
		(echo "RoundCube db creation failed" && gunzip -c /var/log/build/roundcube.log.gz && exit 1)
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["webmail"]
