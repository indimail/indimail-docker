FROM fedora:28
MAINTAINER cprogrammer

COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root
RUN dnf -y install 'dnf-command(config-manager)' \
	&& dnf config-manager --add-repo https://download.opensuse.org/repositories/home:mbhangui/Fedora_28/home:mbhangui.repo \
	&& echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN export HOSTNAME=indimail.org \
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
		openssh-server \
		openssl \
		procps \
		systemd \
		telnet \
		vim \
		wget \
		which \
		indimail
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org \
	&& unset HOSTNAME
