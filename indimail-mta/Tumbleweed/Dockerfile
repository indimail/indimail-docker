FROM opensuse/tumbleweed
MAINTAINER cprogrammer

RUN export HOSTNAME=indimail.org \
	&& mkdir -p /root \
	&& zypper --non-interactive update \
	&& zypper --non-interactive install \
		wget \
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
		patch \
	&& zypper --non-interactive addrepo https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Tumbleweed/home:mbhangui.repo \
	&& zypper --non-interactive addrepo https://download.opensuse.org/repositories/server:database/openSUSE_Tumbleweed/server:database.repo \
	&& zypper --non-interactive addrepo https://download.opensuse.org/repositories/server:monitoring/openSUSE_Tumbleweed/server:monitoring.repo \
	&& zypper --non-interactive --gpg-auto-import-keys refresh \
	&& zypper --non-interactive --gpg-auto-import-keys install \
		indimail-mta \
		mrtg \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null \
	&& systemctl disable sshd \
	&& unset HOSTNAME
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
