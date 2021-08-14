# docker build -f dockerfile.ubi8 -t cprogrammer/indimail:ubi8
# run dpkg-reconfigure tzdata after starting the container
From registry.access.redhat.com/ubi8/ubi-init
#From redhat/ubi8:latest
MAINTAINER cprogrammer
LABEL org.opencontainers.image.source=https://github.com/mbhangui/indimail:ubi8

RUN export HOSTNAME=indimail.org DEBIAN_FRONTEND=noninteractive \
	MYSQL_SOCKET=/run/mysqld/mysqld.sock \
	&& mkdir -p /root /usr/local/srctmp \
	&& dnf config-manager --set-enabled ubi-8-baseos-source ubi-8-appstream-source \
	&& dnf -y install \
		https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
		https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm \
		http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/numactl-libs-2.0.12-11.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages/libidn-devel-1.34-5.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/libidn2-devel-2.2.0-1.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/pam-devel-1.3.1-14.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/flex-2.6.1-9.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/xmlto-0.0.28-7.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/docbook-dtds-1.0-69.el8.noarch.rpm \
		http://repo.okay.com.mx/centos/8/x86_64/release/docbook-style-xsl-1.79.2-8.el8.noarch.rpm \
		http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/sgml-common-0.6.3-50.el8.noarch.rpm  \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/libev-devel-4.24-6.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/libev-4.24-6.el8.x86_64.rpm \
		http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/gettext-devel-0.19.8.1-17.el8.i686.rpm \
		http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/gettext-common-devel-0.19.8.1-17.el8.noarch.rpm \
		http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/telnet-0.17-76.el8.x86_64.rpm \
	&& dnf -y install --allowerasing gcc gcc-c++ make automake autoconf libtool git \
		mysql-community-server mysql-devel \
		openssl-devel openldap-devel ncurses-devel gd-devel libidn-devel libidn2-devel pcre-devel libsodium-devel \
		libdb-devel pam-devel \
		diffutils coreutils which chkconfig procps psmisc flex less cronie xmlto \
		file sed wget bzip2 \
	&& (set -e; \
		cd /usr/local/srctmp; \
		wget -nv https://oss.oetiker.ch/mrtg/pub/mrtg.tar.gz \
			-O /usr/local/srctmp/mrtg.tar.gz; \
		tar xf mrtg.tar.gz; \
		cd mrtg-2.17.7; \
		./configure --prefix=/usr; make && make install; \
		cd /usr/local/srctmp; \
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
		chmod +x /service/.svscan/run; \
		echo "1" > /service/.svscan/variables/WAIT_INITCMD; \
		# tinydnssec ###########################################
		echo "building tinydnssec"; \
		cd /usr/local/srctmp/tinydnssec/tinydnssec-x; \
		./default.configure; \
		sed -i 's/^cc/cc -s/' conf-ld; \
		sed -i 's/ -g//' conf-cc; \
		make; \
		/usr/bin/core_perl/pod2man -s 8 -c '' "tinydns-sign" >tinydns-sign.8; \
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
		echo "adding podman/docker script to /service/.svscan/run"; \
		( echo "/usr/sbin/svctool --config=recontrol"; \
		 echo "cd /var/indimail/queue"; \
		 echo "for i in queue*; do queue-fix -v \$i; done"; \
		 echo "for i in slowq nqueue; do if [ -d \$i ] ; then queue-fix \$i; fi; done"; \
		 echo "for i in qmta; do if [ -d \$i ] ; then queue-fix -mv \$i; fi; done"; \
		) >> /service/.svscan/run; \
		) 2>&1 | tee -a /tmp/build.log \
	&& dnf -y install mailx \
	&& /bin/rm -rf /usr/local/srctmp /usr/lib/libeps.la /usr/lib/libindimail.la \
		/usr/lib/libqmail.la /usr/lib/libdkim.la /usr/lib/libflash.la \
		/usr/lib/libnss_nssd.la /usr/lib/libsrs2.la /usr/lib/libqmail.a \
		/usr/lib/libindimail.a /usr/lib/libcourier-unicode.a \
		/usr/lib/libdkim.a /usr/lib/libsrs2.a /lib/security/pam-multi.la \
	&& dnf -y erase gcc autoconf automake make git \
		xmlto docbook-dtds sgml-common docbook-style-xsl \
	&& unset HOSTNAME \
	&& echo "Build Completed" 
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]
ENTRYPOINT ["docker-entrypoint"]
CMD ["indimail"]
