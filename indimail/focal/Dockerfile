# docker build -f dockerfile.focal -t cprogrammer/indimail:focal
# run dpkg-reconfigure tzdata after starting the container
From ubuntu:focal
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root/debian \
	&& mkdir -p /var/run/mysqld \
	&& apt-get -y update \
	&& apt-get -y install \
		wget \
		gnupg2 \
		apt-utils \
		mysql-server-8.0 \
	&& chown mysql:mysql /var/run/mysqld \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/indimail-mta_2.10-1.1_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/indimail_3.0-10_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/libindimail_3.0-10_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/iwebadmin_2.0-1_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/bogofilter-wordlist_1.0-1_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/ezmlm-idx_7.2.2-1.4_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/ezmlm-idx-cgi_7.2.2-1.4_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/ezmlm-idx-mysql_7.2.2-1.4_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/libqmail_0.1-6_amd64.deb -P /root/debian \
	&& wget http://downloads.sourceforge.net/indimail/Repo/Ubuntu-20.04/libqmail-dev_0.1-6_amd64.deb -P /root/debian \
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
		libgsl23 \
		libidn11 \
		libmysqlclient21 \
		mysql-server \
	&& dpkg -i /root/debian/libqmail_0.1-6_amd64.deb \
	&& dpkg -i /root/debian/indimail-mta_2.10-1.1_amd64.deb \
	&& dpkg -i /root/debian/bogofilter-wordlist_1.0-1_amd64.deb \
	&& dpkg -i \
		/root/debian/indimail_3.0-10_amd64.deb \
		/root/debian/libindimail_3.0-10_amd64.deb \
	&& dpkg -i /root/debian/ezmlm-idx_7.2.2-1.4_amd64.deb \
	&& dpkg -i \
		/root/debian/ezmlm-idx-cgi_7.2.2-1.4_amd64.deb \
		/root/debian/ezmlm-idx-mysql_7.2.2-1.4_amd64.deb \
		/root/debian/iwebadmin_2.0-1_amd64.deb \
	&& /bin/rm -rf /root/debian \
	&& echo "/usr/lib/x86_64-linux-gnu/libmysqlclient.so.21.1.19" > /etc/indimail/mysql_lib \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
