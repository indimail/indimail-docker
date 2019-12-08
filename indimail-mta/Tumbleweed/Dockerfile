FROM opensuse/tumbleweed
MAINTAINER cprogrammer

# Freshen RUN apt-get -y update
RUN zypper --non-interactive install wget openssl vim net-tools procps systemd less telnet \
		openssh which systemd-sysvinit sudo patch
RUN zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/home:mbhangui/openSUSE_Tumbleweed/home:mbhangui.repo
RUN zypper --non-interactive addrepo \
		https://download.opensuse.org/repositories/server:database/openSUSE_Tumbleweed/server:database.repo
RUN zypper --non-interactive --gpg-auto-import-keys refresh
RUN zypper --non-interactive --gpg-auto-import-keys install indimail-mta
RUN /usr/sbin/svctool --config=cert --postmaster=postmaster@indimail.org --common_name=indimail.org > /dev/null
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
