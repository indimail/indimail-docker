# docker build -f dockerfile.noble -t cprogrammer/indimail:noble
# run dpkg-reconfigure tzdata after starting the container
From ubuntu:noble
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-docker/blob/master/indimail/noble/Dockerfile
EXPOSE 25/tcp
EXPOSE 106/tcp
EXPOSE 209/tcp
EXPOSE 366/tcp
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

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root/Downloads \
	&& sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
		/etc/dpkg/dpkg.cfg.d/excludes \
	&& apt-get -y update \
	&& apt-get -y install curl gnupg2 apt-utils \
	&& curl -fsSL https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb -o /root/Downloads/mysql-apt_config.deb \
	&& apt-get -y install /root/Downloads/mysql-apt_config.deb \
	&& curl -fsSL https://download.opensuse.org/repositories/home:mbhangui/xUbuntu_24.04/Release.key | \
		gpg --dearmor > /etc/apt/trusted.gpg.d/home_mbhangui.gpg \
	&& printf "deb http://download.opensuse.org/repositories/home:/mbhangui/xUbuntu_24.04/ /\n" > /etc/apt/sources.list.d/indimail.list \
	&& printf "Package: *\nPin: origin download.opensuse.org\nPin-Priority: 1001\n"             > /etc/apt/preferences.d/preferences \
	&& apt-get -y update \
	&& apt-get -y install \
		libmysqlclient21 \
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
		bsd-mailx \
		libnet-ssleay-perl \
		libauthen-sasl-perl \
		libdigest-perl-md5-perl \
		libdigest-hmac-perl \
		gsasl \
	&& find /usr/lib/x86_64-linux-gnu -name libmysqlclient.so.'*'.'*' > /etc/indimail/control/libmysql \
	&& apt-get -y install \
		indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& /bin/rm -rf /run /root/Downloads \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
