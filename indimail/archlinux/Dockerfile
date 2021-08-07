# docker build -f dockerfile.archlinux -t cprogrammer/indimail:archlinux
# run dpkg-reconfigure tzdata after starting the container
From archlinux:latest
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail:archlinux

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root /usr/local/srctmp \
	&& sed -i 's{usr/share/man/\*{{g' /etc/pacman.conf \
	&& pacman-key --init \
	&& pacman -Sy --noconfirm --needed \
	&& pacman -S --noconfirm --needed archlinux-keyring \
	&& pacman -S --noconfirm --refresh --sysupgrade \
	&& pacman -Sy --noconfirm base-devel diffutils coreutils openssl \
		openldap mysql libidn2 wget gd man-db man-pages \
		libsodium \
	&& (set -e; \
		cd /usr/local/srctmp; \
		wget -nv https://oss.oetiker.ch/mrtg/pub/mrtg.tar.gz \
			-O /usr/local/srctmp/mrtg.tar.gz; \
		tar xf mrtg.tar.gz; \
		cd mrtg-2.17.7; \
		./configure --prefix=/usr; make && make install; \
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
		mailx syslog-ng logrotate libidn \
		indimail-mta logalert procmail indimail-access \
		bogofilter-wordlist indimail-auth indimail-utils \
		indimail ezmlm-idx tinydnssec \
	&& pacman -S --noconfirm indimail-spamfilter \
	&& echo "Creating self-signed certificate" \
	&& /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org >/dev/null 2>/tmp/cert.log \
	&& (set -e; \
		echo "/usr/sbin/svctool --config=recontrol"; \
		echo "cd /var/indimail/queue"; \
		echo "for i in queue*; do queue-fix -v \$i; done"; \
		echo "for i in slowq nqueue; do if [ -d \$i ] ; then queue-fix \$i; fi; done"; \
		echo "for i in qmta; do if [ -d \$i ] ; then queue-fix -mv \$i; fi; done"; \
		) > /service/.svscan/run \
	&& chmod +x /service/.svscan/run \
	&& /bin/rm -rf /usr/local/srctmp \
	&& echo "1" > /service/.svscan/variables/WAIT_INITCMD \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
