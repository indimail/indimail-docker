# docker build -f dockerfile.alpine -t cprogrammer/indimail:alpine
From alpine:latest
MAINTAINER cprogrammer

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	&& mkdir -p /root /usr/local/src \
	&& apk -U upgrade \
	&& apk add bash gcc g++ make git autoconf automake libtool m4 sed \
		pkgconfig openssl openrc mailx busybox-extras vim lsof strace \
		mandoc man-pages mandoc-apropos dcron dcron-openrc \
		inetutils-syslogd inetutils-syslogd-openrc util-linux \
		openssh openssh-server xmlto \
		apk-tools-doc openrc-doc dcron-doc inetutils-syslogd-doc \
		openssl-dev openssl-dev fts-dev mysql-dev musl-nscd-dev \
		libidn-dev libidn2-dev pcre-dev libtirpc-dev ncurses-dev \
		linux-pam-dev gdbm-dev db-dev gsl-dev \
	&& (cd /usr/local/src; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/libqmail.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-mta.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-virtualdomains.git; \
	#indimail-mta
		cd /usr/local/src/libqmail; \
		./default.configure; \
		make -s && make -s install-strip; \
		cd /usr/local/src/indimail-mta/libdkim-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		cd /usr/local/src/indimail-mta/libsrs2-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		cd /usr/local/src/indimail-mta/indimail-mta-x; \
		./default.configure; \
		echo "cc -s -rdynamic -fPIE" > conf-ld; \
		echo "cc -fPIC -O2 -Wall -I/usr/include/qmail" > conf-cc; \
		make; \
		./svctool --config=users; \
		make install-strip; \
		cd ../daemontools-x; \
		./default.configure; \
		echo "cc -s -rdynamic" > conf-ld; \
		echo "cc -fPIC -O2 -Wall -I/usr/include/qmail" > conf-cc; \
		make && make install-strip; \
		cd ../ucspi-tcp-x; \
		./default.configure; \
		echo "cc -s" > conf-ld; \
		echo "cc -fPIC -O2 -Wall -I/usr/include/qmail" > conf-cc; \
		make && make install-strip; \
		echo "Creating self-signed certificate"; \
		/usr/sbin/svctool \
			--config=cert --postmaster=postmaster@indimail.org \
			--common_name=indimail.org > /dev/null 2>/tmp/cert.log; \
	#indimail
		cd /usr/local/src/indimail-virtualdomains/indimail-x; \
		./default.configure; \
		make && make install-includeHEADERS && make install-libindimailLTLIBRARIES; \
		cd /usr/local/src/indimail-virtualdomains/pam-multi-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../nssd-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../courier-imap-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../fetchmail-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../logalert-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../procmail-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../mpack-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../flash-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../altermime-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../ripmime-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../fortune-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../indimail-spamfilter-x; \
		./default.configure; \
		make && make install-strip; \
		cd ../bogofilter-wordlist-x; \
		./default.configure; \
		make && make install-strip; \
		cd /usr/local/src/indimail-mta/indimail-mta-x; \
		./create_services --add-boot; \
		( echo "cd /var/indimail/queue"; \
		 echo "for i in queue*; do queue-fix -v \$i; done"; \
		 echo "for i in slowq nqueue; do if [ -d \$i ] ; then queue-fix \$i; fi; done"; \
		 echo "for i in qmta; do if [ -d \$i ] ; then queue-fix -mv \$i; fi; done"; \
		 cd /service/.svscan ) > /service/.svscan/run; \
		 chmod +x /service/.svscan/run; \
		 echo "1" > /service/.svscan/variables/WAIT_INITCMD; \
		 echo "::respawn:/usr/libexec/indimail/svscanboot /service" >> /etc/inittab; \
		) 2>&1 | tee -a /tmp/build.log \
	&& (sed -i 's/^tty/#tty/g' /etc/inittab; \
		rc-update add dcron; \
		rc-update add inetutils-syslogd; \
		rc-update add svscan; \
		sed 's/ root / /g' /etc/indimail/cronlist.q |crontab -; \
		sed -i '/^kern\|^lpr/d' /etc/syslog.conf; \
		[ ! -f /etc/nsswitch.conf ] && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf; \
		/usr/sbin/svctool --config=add-alt; \
	   ) \
	&& /bin/rm -rf /usr/local/src \
	&& apk del gcc g++ make git autoconf automake libtool m4 \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail-mta"]

