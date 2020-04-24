# docker build -f dockerfile.focal -t cprogrammer/indimail:focal
# run dpkg-reconfigure tzdata after starting the container
From ubuntu:focal
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root/debian \
	&& apt-get -y update \
	&& apt-get -y install wget gnupg2 apt-utils \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/indimail-mta_2.10-1.1_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/libqmail_0.1-6_amd64.deb -P /root/debian \
	&& apt-get -y install \
		debianutils \
		binutils \
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
		libmysqlclient21 \
	&& dpkg -i \
		/root/debian/libqmail_0.1-6_amd64.deb \
		/root/debian/indimail-mta_2.10-1.1_amd64.deb \
	&& /bin/rm -rf /root/debian \
	&& echo "/usr/lib/x86_64-linux-gnu/libmysqlclient.so.21.1.19" > /etc/indimail/mysql_lib \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
