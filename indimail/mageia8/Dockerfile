# docker build -f dockerfile.mageia8 -t cprogrammer/indimail:mageia8
FROM mageia:8
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-docker/blob/master/indimail/mageia8/Dockerfile
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

RUN export HOSTNAME=indimail.org \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
	&& dnf -y install 'dnf-command(config-manager)' \
	&& dnf -y copr enable cprogrammer/indimail \
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
	&& dnf -y install \
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
		krb5-appl-clients \
		vim \
		wget \
		which \
		strace \
		lsof \
		deltarpm \
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
