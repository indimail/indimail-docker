# docker build -f dockerfile.xenial -t cprogrammer/indimail:xenial
From ubuntu:xenial
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root \
	&& apt-get -y update \
	&& apt-get -y install wget gnupg2 apt-utils \
	&& wget -nv https://download.opensuse.org/repositories/home:mbhangui/xUbuntu_16.04/Release.key -O - | apt-key add - \
	&& echo 'deb http://download.opensuse.org/repositories/home:/mbhangui/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/indimail.list \
	&& apt-get -y update \
	&& apt-get -y install \
		debianutils \
		cron \
		less \
		man-db \
		net-tools \
		openssh-server \
		openssl \
		procps \
		psmisc \
		systemd \
		systemd-sysv \
		telnet \
		strace \
		lsof \
		vim \
		mrtg \
		indimail \
		iwebadmin \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
