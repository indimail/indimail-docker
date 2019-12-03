# docker build -f dockerfile.xenial -t cprogrammer/indimail:xenial
From ubuntu:bionic
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root \
	&& apt-get -y update \
	&& apt-get install -y wget gnupg2 \
	&& wget -nv https://download.opensuse.org/repositories/home:mbhangui/xUbuntu_18.04/Release.key -O - | apt-key add - \
	&& echo 'deb http://download.opensuse.org/repositories/home:/mbhangui/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/indimail.list \
	&& apt-get -y update \
	&& apt-get -y install \
		debianutils \
		less \
		man-db \
		net-tools \
		openssh-server \
		openssl \
		procps \
		systemd \
		systemd-sysv \
		telnet \
		strace \
		lsof
		vim \
	&& apt-get -y install mrtg indimail \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
