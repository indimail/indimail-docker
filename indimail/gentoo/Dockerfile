# docker build -f dockerfile.gentoo -t cprogrammer/indimail:gentoo
From gentoo/stage3:latest
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail:gentoo

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root /usr/local/srctmp /run/mysqld \
	&& emaint -ay sync \
	&& emerge-webrsync \
	&& emerge -a --ask n dev-vcs/git \
	&& emerge -a --ask n dev-db/mysql \
	&& emerge -a --ask n openldap \
	&& emerge -a --ask n openrc \
	&& emerge -a --ask n openssh \
	&& emerge -a --ask n net-dns/libidn \
	&& emerge -a --ask n app-text/xmlto \
	&& emerge -a --ask n sys-apps/init-system-helpers \
	&& emerge -a --ask n net-analyzer/mrtg \
	&& emerge -a --ask n sys-process/cronie \
	&& emerge -a --ask n app-admin/rsyslog \
	&& emerge -a --ask n dev-libs/libev \
	&& emerge -a --ask n dev-libs/libsodium \
	&& (cd /usr/local/srctmp; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/libqmail.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-mta.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/indimail-virtualdomains.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/ezmlm-idx.git; \
		git clone --no-tags --no-recurse-submodules --depth=1 https://github.com/mbhangui/tinydnssec.git; \
		# libqmail #############################################
		cd /usr/local/srctmp/libqmail; \
		./default.configure; \
		make -s && make -s install-strip; \
		# libdkim ##############################################
		cd /usr/local/srctmp/indimail-mta/libdkim-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		# libsrs2 ##############################################
		cd /usr/local/srctmp/indimail-mta/libsrs2-x; \
		./default.configure; \
		make -s && make -s install-strip; \
		# indimail-mta #########################################
		cd /usr/local/srctmp/indimail-mta/indimail-mta-x; \
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
		# ezmlm-idx ############################################
		cd /usr/local/srctmp/ezmlm-idx/ezmlm-idx-x; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/^cc/cc -s/' conf-ldso; \
		sed -i 's/ -g//' conf-cc; \
		./default.configure; \
		make && make install; \
		# indimail-virtualdomains ##############################
		cd /usr/local/srctmp/indimail-virtualdomains/indimail-x; \
		./default.configure; \
		make && make install-strip \
		# pam-multi ############################################
		cd /usr/local/srctmp/indimail-virtualdomains/pam-multi-x; \
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
		cd /usr/local/srctmp/indimail-mta/indimail-mta-x; \
		./create_services --add-boot --mbase=/home/mail --mysqlPrefix=/usr; \
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
		cd /usr/local/srctmp/tinydnssec/tinydnssec-x; \
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
		/bin/rm -rf /etc/runlevels/boot /etc/runleves/sysinit \
			/etc/runlevels/nonetwork /etc/runlevels/shutdown/mount-ro; \
		/bin/rm -f /lib/rc/sh/rc-cgroup.sh; \
		rc-update add cronie default; \
		rc-update add rsyslog default; \
		rc-update add sshd default; \
		mkdir /etc/runlevels/indimail; \
		rc-update add cronie indimail; \
		rc-update add rsyslog indimail; \
		rc-update add sshd indimail; \
		sed -i '/imklog/ s/^#*/#/' /etc/rsyslog.conf; \
		) \
	&& /bin/rm -rf /usr/local/srctmp /usr/lib/libeps.la /usr/lib/libindimail.la \
		/usr/lib/libqmail.la /usr/lib/libdkim.la /usr/lib/libflash.la \
		/usr/lib/libnss_nssd.la /usr/lib/libsrs2.la /usr/lib/libqmail.a \
		/usr/lib/libindimail.a /usr/lib/libcourier-unicode.a \
		/usr/lib/libdkim.a /usr/lib/libsrs2.a /lib/security/pam-multi.la \
	&& /bin/rm -rf /run \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
