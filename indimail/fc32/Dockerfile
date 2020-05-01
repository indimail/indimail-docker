# docker build -f dockerfile.fc32 -t cprogrammer/indimail:fc32
FROM fedora:32
MAINTAINER cprogrammer

RUN dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager \
		--add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_32/home:mbhangui.repo
RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& dnf -y update \
	&& dnf -y install \
		binutils \
		gnupg2 \
		hostname \
		initscripts \
		less \
		mailx \
		man-db \
		mrtg \
		net-tools \
		openssh-clients \
		openssh-server \
		openssl \
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
		deltarpm \
		indimail \
		ezmlm-idx \
		ezmlm-idx-cgi \
		ezmlm-idx-mysql \
		iwebadmin \
	&& /usr/sbin/svctool \
		--config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null 2>/tmp/cert.log \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
