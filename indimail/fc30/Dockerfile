FROM fedora:30
MAINTAINER cprogrammer

COPY docker-entrypoint.sh /usr/bin
RUN dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager --add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_30/home:mbhangui.repo
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
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/tmp/cert.log 2>&1\
	&& chmod 755 /usr/bin/docker-entrypoint.sh \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["indimail"]
