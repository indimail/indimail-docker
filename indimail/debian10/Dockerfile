# docker build -f dockerfile.debian10 -t cprogrammer/indimail:debian10
FROM debian:10
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail:debian10

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root \
	&& apt-get -y update \
	&& apt-get -y install wget gnupg2 apt-utils \
	&& wget -nv https://download.opensuse.org/repositories/home:mbhangui/Debian_10/Release.key -O - | apt-key add - \
	&& printf "deb http://download.opensuse.org/repositories/home:/mbhangui/Debian_10/ /\n" > /etc/apt/sources.list.d/indimail.list  \
	&& printf "Package: *\nPin: origin download.opensuse.org\nPin-Priority: 1001\n"         > /etc/apt/preferences.d/preferences \
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
		inetutils-ping \
		vim \
		indimail-mta \
		logalert \
		procmail \
		indimail \
		indimail-auth \
		indimail-access \
		indimail-utils \
		bogofilter-wordlist \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		libnet-ssleay-perl \
		libauthen-sasl-perl \
		libdigest-perl-md5-perl \
		libdigest-hmac-perl \
		gsasl \
	&& apt-get -y install \
		indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
