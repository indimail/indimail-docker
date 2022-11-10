# docker build -f dockerfile.archlinux -t cprogrammer/indimail:archlinux
# run dpkg-reconfigure tzdata after starting the container
From archlinux:latest
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail:archlinux

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root /usr/local/srctmp \
	&& sed -i 's{usr/share/man/\*{{g' /etc/pacman.conf \
	&& pacman -Sy --noconfirm --needed \
	&& pacman -S  --noconfirm --refresh --sysupgrade \
	&& pacman -S  --noconfirm --needed archlinux-keyring \
	&& pacman -Sy --noconfirm --needed base-devel git meson diffutils coreutils \
		openssl openldap mysql libidn2 wget gd man-db man-pages \
		libsodium cronie syslog-ng \
	&& (set -e; \
		cd /usr/local/srctmp; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/OpenRC/openrc.git; \
		cd /usr/local/srctmp/openrc; \
		meson build && cd build && DESTDIR="" meson install; \
		cd /usr/local/srctmp; \
		wget -nv https://oss.oetiker.ch/mrtg/pub/mrtg.tar.gz \
			-O /usr/local/srctmp/mrtg.tar.gz; \
		tar xf mrtg.tar.gz && /bin/rm -f mrtg.tar.gz; \
		cd mrtg-*; \
		./configure --prefix=/usr; make && make install; \
		/bin/rm -rf /usr/local/srctmp; \
	   ) \
	&& (set -e; \
		(echo "[home_mbhangui_Arch]"; \
		 echo "Server = https://download.opensuse.org/repositories/home:/mbhangui/Arch/\$arch"; \
		 echo "SigLevel = Optional";) >> /etc/pacman.conf; \
		key=$(curl -fsSL https://download.opensuse.org/repositories/home:mbhangui/Arch/$(uname -m)/home_mbhangui_Arch.key); \
		fingerprint=$(gpg --quiet --with-colons --import-options show-only --import --fingerprint <<< "${key}" | awk -F: '$1 == "fpr" { print $10 }'); \
		pacman-key --init; \
		pacman-key --add - <<< "${key}"; \
		pacman-key --lsign-key "${fingerprint}"; \
		pacman -Sy --noconfirm ) \
	&& pacman -S --needed --noconfirm \
		binutils cronie net-tools openssl openssh strace lsof vim \
		inetutils mailx syslog-ng logrotate libidn which \
		indimail-mta logalert procmail indimail-access \
		bogofilter-wordlist indimail-auth indimail-utils \
		tinydnssec \
	&& pacman -S --noconfirm indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& (set -e; \
		mkdir -p /etc/init.d; \
		wget -nv https://raw.githubusercontent.com/mbhangui/docker/master/misc/cronie    -O /etc/init.d/cronie ; \
		wget -nv https://raw.githubusercontent.com/mbhangui/docker/master/misc/syslog-ng -O /etc/init.d/syslog-ng ; \
		wget -nv https://raw.githubusercontent.com/mbhangui/docker/master/misc/sshd      -O /etc/init.d/sshd ; \
		/bin/cp /usr/share/indimail/boot/openrc /etc/init.d/svscan; \
		chmod +x /etc/init.d/cronie /etc/init.d/syslog-ng /etc/init.d/sshd \
			/etc/init.d/svscan; \
		sed -i \
			-e '/f_kernel/d;/f_lpr/d;/f_mail/d;/f_news/d;/f_uucp/d;/f_ppp/d;/f_debug/d;/f_everything/d' \
			-e '/d_kernel/d;/d_lpr/d;/d_mail/d;/d_news/d;/d_uucp/d;/d_ppp/d;/d_debug/d;/d_everything/d' \
			-e '/console_all/d; /tty12/d; /d_console/d' \
			/etc/syslog-ng/syslog-ng.conf; \
		sed -i '/need hostname/d' /etc/init.d/syslog-ng; \
		systemctl mask proc-sys-fs-binfmt_misc.automount \
			systemd-journald-audit.socket sys-kernel-tracing.mount \
			sys-kernel-debug.mount sys-kernel-config.mount; \
		systemctl enable cronie.service syslog-ng@default.service sshd.service; \
		/bin/rm -rf /etc/runlevels/boot /etc/runlevels/sysinit \
			/etc/runlevels/nonetwork; \
		/bin/rm -f /libexec/rc/sh/rc-cgroup.sh /etc/runlevels/default/local \
			/etc/runlevels/default/netmount /etc/runlevels/shutdown/mount-ro \
			/etc/runlevels/shutdown/savecache; \
		mkdir -p /run/openrc; \
		touch /run/openrc/softlevel; \
		mkdir -p /etc/runlevels/indimail; \
		/sbin/rc-update add cronie indimail; \
		/sbin/rc-update add syslog-ng indimail; \
		/sbin/rc-update add sshd indimail; \
		/sbin/rc-update add svscan indimail; \
		) \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]
