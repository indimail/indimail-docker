# docker build -f dockerfile.alpine -t cprogrammer/indimail:alpine
From alpine:latest
MAINTAINER cprogrammer

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root /usr/local/src \
	&& apk -U upgrade \
	&& apk add bash gcc g++ make git autoconf automake libtool m4 sed \
		pkgconfig openssl openrc mailx busybox-extras vim lsof strace \
		mandoc man-pages mandoc-apropos dcron dcron-openrc \
		inetutils-syslogd inetutils-syslogd-openrc util-linux \
		openssh openssh-server xmlto mrtg \
		apk-tools-doc openrc-doc dcron-doc inetutils-syslogd-doc \
		openssl-dev openssl-dev fts-dev mysql-dev musl-nscd-dev \
		libidn-dev libidn2-dev pcre-dev libtirpc-dev ncurses-dev \
		linux-pam-dev gdbm-dev db-dev gsl-dev \
		mysql mysql-client \
	&& (cd /usr/local/src; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/libqmail.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-mta.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-virtualdomains.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/ezmlm-idx.git; \
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
	#ezmlm-idx
		cd /usr/local/src/ezmlm-idx/ezmlm-idx-x; \
		echo "cc -s -rdynamic" > conf-ld; \
		echo "cc -Wall -Wshadow -O2 -fPIC -fno-strict-aliasing" > conf-cc; \
		echo "cc -s -shared -fPIC" > conf-ldso; \
		./default.configure; \
		make && make install; \
	#indimail
		cd /usr/local/src/indimail-virtualdomains/indimail-x; \
		./default.configure; \
		make && make install-strip; \
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
		./create_services --add-boot --mbase=/home/mail --mysqlPrefix=/usr; \
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
		/sbin/rc-update add dcron; \
		/sbin/rc-update add inetutils-syslogd; \
		/sbin/rc-update add svscan; \
		(sed 's/ root / /g' /etc/indimail/cronlist.q; \
		sed 's/ root / /g' /etc/indimail/cronlist.i;) |crontab -; \
		sed 's/ indimail / /g' /etc/indimail/cronlist.i | crontab -u indimail -; \
		sed -i '/^kern\|^lpr/d' /etc/syslog.conf; \
		[ ! -f /etc/nsswitch.conf ] && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf; \
		/usr/sbin/svctool --config=add-alt; \
	   ) \
	&& /bin/rm -rf /usr/local/src /usr/lib/libcourier-unicode.la /usr/lib/libeps.la \
		/usr/lib/libindimail.la /usr/lib/libqmail.la /usr/lib/libdkim.la \
		/usr/lib/libflash.la /usr/lib/libnss_nssd.la /usr/lib/libsrs2.la \
		/lib/security/pam-multi.la \
	&& apk del gcc g++ make git autoconf automake libtool m4 \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
