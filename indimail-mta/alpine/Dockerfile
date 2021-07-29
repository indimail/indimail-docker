# docker build -f dockerfile.alpine -t cprogrammer/indimail-mta:alpine
From alpine:latest
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail-mta:alpine

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root /usr/local/src \
	&& apk -U upgrade \
	&& apk add bash gcc g++ make git autoconf automake libtool m4 sed \
		pkgconfig openssl openrc mailx busybox-extras vim lsof strace \
		mandoc man-pages mandoc-apropos dcron dcron-openrc \
		inetutils-syslogd inetutils-syslogd-openrc util-linux \
		openssh openssh-server xmlto \
		apk-tools-doc openrc-doc dcron-doc inetutils-syslogd-doc \
		openssl openssl-dev fts fts-dev mariadb-connector-c mysql-dev \
		musl-nscd musl-nscd-dev libidn libidn-dev libidn2 libidn2-dev \
		pcre pcre-dev libtirpc libtirpc-dev ncurses-libs ncurses-dev \
		linux-pam linux-pam-dev gdbm gdbm-dev db db-dev gsl gsl-dev \
		libev libev-dev \
	&& (cd /usr/local/src; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/libqmail.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-mta.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-virtualdomains.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/tinydnssec.git; \
		# libqmail #############################################
		cd /usr/local/src/libqmail; \
		./default.configure; \
		make -s && make -s install-strip; \
		# libdkim ##############################################
		cd /usr/local/src/indimail-mta/libdkim-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		# libsrs2 ##############################################
		cd /usr/local/src/indimail-mta/libsrs2-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		# indimail-mta #########################################
		cd /usr/local/src/indimail-mta/indimail-mta-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make; \
		./svctool --config=users; \
		make install-strip; \
		# daemontools ##########################################
		cd ../daemontools-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make && make install-strip; \
		# ucspi-tcp ############################################
		cd ../ucspi-tcp-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make && make install-strip; \
		echo "Creating self-signed certificate"; \
		/usr/sbin/svctool \
			--config=cert --postmaster=postmaster@indimail.org \
			--common_name=indimail.org > /dev/null 2>/tmp/cert.log; \
		# indimail-virtualdomains ##############################
		cd /usr/local/src/indimail-virtualdomains/indimail-x; \
		./default.configure; \
		make && make install-includeHEADERS && make install-libindimailLTLIBRARIES; \
		# pam-multi ############################################
		cd /usr/local/src/indimail-virtualdomains/pam-multi-x; \
		./default.configure; \
		make && make install-strip; \
		# nssd #################################################
		cd ../nssd-x; \
		./default.configure; \
		make && make install-strip; \
		# courier-imap #########################################
		cd ../courier-imap-x; \
		./default.configure; \
		make && make install-strip; \
		# fetchmail ############################################
		cd ../fetchmail-x; \
		./default.configure; \
		make && make install-strip; \
		# logalert #############################################
		cd ../logalert-x; \
		./default.configure; \
		make && make install-strip; \
		# procmail #############################################
		cd ../procmail-x; \
		./default.configure; \
		make && make install-strip; \
		# mpack ################################################
		cd ../mpack-x; \
		./default.configure; \
		make && make install-strip; \
		# flash ################################################
		cd ../flash-x; \
		./default.configure; \
		make && make install-strip; \
		# alertime #############################################
		cd ../altermime-x; \
		./default.configure; \
		make && make install-strip; \
		# ripmime ##############################################
		cd ../ripmime-x; \
		./default.configure; \
		make && make install-strip; \
		# fortune ##############################################
		cd ../fortune-x; \
		./default.configure; \
		make && make install-strip; \
		# indimail-spamfilter ##################################
		cd ../indimail-spamfilter-x; \
		./default.configure; \
		make && make install-strip; \
		# bogofilter-wordlist ##################################
		cd ../bogofilter-wordlist-x; \
		./default.configure; \
		make && make install-strip; \
		# configure indimail-mta ###############################
		cd /usr/local/src/indimail-mta/indimail-mta-x; \
		./create_services --add-boot; \
		( echo "/usr/sbin/svctool --config=recontrol"; \
		 echo "cd /var/indimail/queue"; \
		 echo "for i in queue*; do queue-fix -v \$i; done"; \
		 echo "for i in slowq nqueue; do if [ -d \$i ] ; then queue-fix \$i; fi; done"; \
		 echo "for i in qmta; do if [ -d \$i ] ; then queue-fix -mv \$i; fi; done"; \
		) > /service/.svscan/run; \
		chmod +x /service/.svscan/run; \
		echo "1" > /service/.svscan/variables/WAIT_INITCMD; \
		# tinydnssec ###########################################
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
		echo "./configure.nacl"; \
		./configure.nacl; \
		echo "./configure.curvedns"; \
		./configure.curvedns; \
		echo "building curvedns"; \
		make; \
		install -m 0755 -s curvedns /usr/bin; \
		install -m 0755 -s curvedns-keygen /usr/sbin; \
		install -m 0644 curvedns.8 curvedns-keygen.8 /usr/share/man/man8; \
		install -m 0600 curvedns.private.key /etc/indimail//curvedns.private.key; \
		cd ..; ./dnssvc; \
		) 2>&1 | tee -a /tmp/build.log \
	&& (sed -i 's/^tty/#tty/g' /etc/inittab; \
		rc-update add dcron; \
		rc-update add inetutils-syslogd; \
		sed 's/ root / /g' /etc/indimail/cronlist.q |crontab -; \
		sed -i '/^kern\|^lpr/d' /etc/syslog.conf; \
		[ ! -f /etc/nsswitch.conf ] && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf; \
		) \
	&& /bin/rm -rf /usr/local/src /usr/lib/libeps.la /usr/lib/libindimail.la \
		/usr/lib/libqmail.la /usr/lib/libdkim.la /usr/lib/libflash.la \
		/usr/lib/libnss_nssd.la /usr/lib/libsrs2.la /usr/lib/libqmail.a \
		/usr/lib/libindimail.a /usr/lib/libcourier-unicode.a \
		/usr/lib/libdkim.a /usr/lib/libsrs2.a /lib/security/pam-multi.la \
	&& apk del openssl-dev fts-dev mysql-dev musl-nscd-dev libidn-dev libidn2-dev \
		pcre-dev libtirpc-dev ncurses-dev linux-pam-dev gdbm-dev db-dev gsl-dev \
		libev-dev \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]

