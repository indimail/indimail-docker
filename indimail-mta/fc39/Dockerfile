# docker build -f dockerfile.fc39 -t cprogrammer/indimail-mta:fc39
FROM fedora:39
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/indimail/indimail-mta:fc39

RUN export HOSTNAME=indimail.org \
	&& sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf \
	&& dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager \
		--add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_39/home:mbhangui.repo \
	&& mkdir -p /root \
	&& dnf -y update \
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
		telnet \
		vim \
		wget \
		which \
		strace \
		lsof \
		passwd \
		iputils \
		deltarpm \
		indimail-mta \
		logalert \
		procmail \
		indimail-auth \
		indimail-access \
		indimail-utils \
		bogofilter-wordlist \
		perl-Authen-SASL \
		perl-Digest-HMAC \
		perl-Digest-SHA \
	&& dnf -y install \
		indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org \
		--common_name=indimail.org > /dev/null 2>/tmp/cert.log || \
		echo "certificate generation failed" \
	&& unset HOSTNAME \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
