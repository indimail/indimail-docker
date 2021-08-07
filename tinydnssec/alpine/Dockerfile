# docker build -f dockerfile.alpine -t cprogrammer/indimail:alpine
From alpine:latest
MAINTAINER cprogrammer

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root /usr/local/src \
	&& apk -U upgrade \
	&& apk add bash gcc g++ make git autoconf automake libtool m4 sed \
		pkgconfig openrc busybox-extras vim lsof strace \
		mandoc man-pages mandoc-apropos util-linux \
		openssh openssh-server apk-tools-doc openrc-doc \
		openssl openssl-dev libev libev-dev libsodium libsodium-dev \
		dcron dcron-openrc dcron-doc \
		inetutils-syslogd inetutils-syslogd-openrc inetutils-syslogd-doc \
	&& (cd /usr/local/src; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/libqmail.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-mta.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/tinydnssec.git; \
		# qmail
		echo "building qmail"; \
		cd /usr/local/src/libqmail; \
		./default.configure; \
		make -s && make -s install-strip; \
		# daemontools
		echo "building daemontools"; \
		cd /usr/local/src/indimail-mta/daemontools-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make && make install-strip; \
		minisvc --config=users; \
		minisvc --svscanlog --servicedir=/service --scanint=60; \
		# save variables
		minisvc --servicedir=/service --service-name=.svscan \
  			--export-variables=/service/.svscan/variables/.variables --force; \
		# tinydnssec
		echo "building tinydnssec"; \
		cd /usr/local/src/tinydnssec/tinydnssec-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make; \
		pod2man -s 8 -c '' "tinydns-sign" >tinydns-sign.8; \
		make install-strip; \
		echo "building dq"; \
		cd dq-20161210; \
		make; \
		sh make-install.sh; \
		cd ../curvedns-0.88; \
		echo "building curvedns"; \
		./default.configure; \
		make; \
		make install-strip; \
		cd ..; ./dnssvc; \
		) 2>&1 | tee -a /tmp/build.log \
	&& (sed -i 's/^tty/#tty/g' /etc/inittab; \
		/sbin/rc-update add dcron; \
		/sbin/rc-update add inetutils-syslogd; \
		minisvc --config=add-boot; \
		sed -i '/^kern\|^lpr/d' /etc/syslog.conf; \
	   ) \
	&& apk del gcc g++ make git autoconf automake libtool openssl-dev libsodium-dev libev-dev m4 \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["svscan"]

