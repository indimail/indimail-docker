# docker build -f dockerfile.amazonlinux -t cprogrammer/indimail:amazonlinux
FROM amazonlinux:2023
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail:amazonlinux

RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
	&& dnf -y install 'dnf-command(config-manager)' \
	&& dnf -y copr enable cprogrammer/indimail amazonlinux-2023-x86_64 \
	&& mkdir -p /root /usr/local/srctmp \
	&& dnf -y update \
	&& dnf -y install tar wget gcc gcc-c++ make autoconf automake libtool gzip gd-devel \
	&& (set -e; \
		cd /usr/local/srctmp; \
		wget -nv https://oss.oetiker.ch/mrtg/pub/mrtg.tar.gz \
			-O /usr/local/srctmp/mrtg.tar.gz; \
		tar xf mrtg.tar.gz && /bin/rm -f mrtg.tar.gz; \
		cd mrtg-*; \
		./configure --prefix=/usr; make && make install; \
		cd /usr/local;/bin/rm -rf srctmp; \
	) \
	&& dnf -y --allowerasing install \
		gnupg2 \
		binutils \
		hostname \
		initscripts \
		less \
		cronie \
		mailx \
		man-db \
		man-pages \
		net-tools \
		openssl \
		openssh-clients \
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
	&& dnf -y install \
		indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org \
		--common_name=indimail.org > /dev/null 2>/tmp/cert.log || \
		echo "certificate generation failed" \
	&& dnf -y erase gcc gcc-c++ autoconf automake libtool \
	&& dnf -y autoremove \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
