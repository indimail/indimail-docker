# docker build -f dockerfile.leap15.5 -t cprogrammer/indimail-mta:leap15.5
FROM opensuse/leap:15.5
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-mta:leap15.5

RUN export HOSTNAME=indimail.org \
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
		iputils \
		patch \
	&& zypper --non-interactive addrepo https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Leap_15.5/home:mbhangui.repo \
	&& zypper --non-interactive addrepo https://download.opensuse.org/repositories/server:database/15.5/server:database.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& zypper --non-interactive --gpg-auto-import-keys install \
		indimail-mta \
		logalert \
		procmail \
		indimail-auth \
		indimail-access \
		indimail-utils \
		bogofilter-wordlist \
		indimail-spamfilter \
		mailx \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& systemctl disable sshd \
	&& unset HOSTNAME \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
