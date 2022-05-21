# Dockerfile repository for automated builds.

This repo contains repository for Dockerfiles used for building docker/podman images for [indimail-mta](https://github.com/mbhangui/indimail-mta), [indimail](https://github.com/mbhangui/indimail-virtualdomains) and [indimail](https://github.com/mbhangui/indimail-virtualdomains) with [roundcube](https://roundcube.net/) web frontend. Read this document on how to run a fully functional mail server using docker / podman images. In just less than an hour, you will read how to run an indimail container and the bonus will be that you will understand how docker and podman works. The correct way to read this document is to read from top to bottom without clicking on any URL. You may click the URL for more information, but there is a chance that you will get distracted / overwhelmed.

You can use either docker or podman. One of the downsides of Docker is it has a central daemon that runs as the root user, and this has security implications. But this is where Podman comes in handy. Podman is a [daemonless container engine](https://podman.io/) for developing, managing, and running [OCI](https://opencontainers.org) Containers on your Linux system in [root or rootless](https://www.tutorialworks.com/podman-rootless-volumes/) mode. The complete set of instructions for installing podman is given [here](https://podman.io/getting-started/installation.html). If you decide to use docker, the complet set of instructions for installing docker is given [here](https://docs.docker.com/engine/install/).

You have to decide the image that you want.

* indimail-mta - for a minimal server that gives you a MTA. This server can receive mails from the internet and send mails to users within the same server or to the internet.
* indimail - For a complete mail server. You can create many virtual domains, access the mails using IMAP or POP3 and do everything that the **indimail-mta** image does.
* indimail-web - Like the **indimail** image with the addition of a web based email client based on [Roundcube Mail](https://roundcube.net/).

Name|Docker Repository Location
----|--------------------------
indimail-mta|[indimail-mta Repository](https://github.com/mbhangui/indimail-mta/pkgs/container/indimail-mta)
indimail|[indimail Repository](https://github.com/mbhangui/indimail-virtualdomains/pkgs/container/indimail)
indimail-web|[indimail+Roundcube Repository](https://github.com/mbhangui/indimail-virtualdomains/pkgs/container/indimail-web)


The following tags/images can be pulled by executing the commands

**Docker**

```
docker pull ghcr.io/mbhangui/indimail-mta:tag
docker pull ghcr.io/mbhangui/indimail:tag
docker pull ghcr.io/mbhangui/indimail-web:tag
```

or

**podman**

```
podman pull ghcr.io/mbhangui/indimail-mta:tag
podman pull ghcr.io/mbhangui/indimail:tag
podman pull ghcr.io/mbhangui/indimail-web:tag
```
Replace tag in the above command with one of the following tags from the below tables (built from Open Build Service or from github sources).

**Runtime Container images built from indimail, indimail-mta packages from [Open Build Service](https://build.opensuse.org)**

tag|OS Distribution|indimai-mta|indimail|webmail
----|--------------|-----------|--------|-------
bionic|Ubuntu 18.04|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-bionic.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-bionic.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-bionic.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-bionic.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-bionic.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-bionic.yml)
focal|Ubuntu 20.04|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-focal.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-focal.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-focal.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-focal.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-focal.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-focal.yml)
hirsute|Ubuntu 21.04|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-hirsute.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-hirsute.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-hirsute.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-hirsute.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-hirsute.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-hirsute.yml)
jammy|Ubuntu 22.04|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-jammy.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-jammy.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-jammy.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-jammy.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-jammy.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-jammy.yml)
debian9|Debian 9|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian9.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian9.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-debian9.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-debian9.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian9.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian9.yml)
debian10|Debian10|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian10.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian10.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-debian10.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-debian10.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian10.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian10.yml)
debian11|Debian11|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian11.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-debian11.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-debian11.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-debian11.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian11.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-debian11.yml)
fc36|Fedora Core 36|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-fc36.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-fc36.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-fc36.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-fc36.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-fc36.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-fc36.yml)
fc35|Fedora Core 35|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-fc35.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-fc35.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-fc35.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-fc35.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-fc35.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-fc33.yml)
Tumbleweed|openSUSE Tumbleweed|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-tumbleweed.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-tumbleweed.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-tumbleweed.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-tumbleweed.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-tumbleweed.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-tumbleweed.yml)
Leap15.4|openSUSE Leap 15.4|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-leap15.4.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-leap15.4.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-leap15.4.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-leap15.4.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-leap15.4.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-leap15.4.yml)
Leap15.3|openSUSE Leap 15.3|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-leap15.3.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-leap15.3.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-leap15.3.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-leap15.3.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-leap15.3.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-leap15.3.yml)
oracle8|Orace Linux 8|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-oracle8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-oracle8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-oracle8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-oracle8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-oracle8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-oracle8.yml)
almalinux8|Alma Linux 8|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-almalinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-almalinux8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-almalinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-almalinux8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-almalinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-almalinux8.yml)
rockylinux8|Rocky Linux 8|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-rockylinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-rockylinux8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-rockylinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-rockylinux8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-web-rockylinux8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-web-rockylinux8.yml)

**Runtime Container images built from Source**

Distributions like alpine, gentoo, archlinux and ubi8 are not supported on the [Open Build Service](https://build.opensuse.org). The runtime images are built using Dockerfiles that pull the source from github, compile and install them. To reduce the build time, these are built in two steps.
1. Build an intermediate image with all source packages installed in the image. The base image comes from the OS distribution images. This image takes very long to build (1.5 hours for gentoo) and is refreshed on a need basis. [![status](https://github.com/mbhangui/indimail-docker/actions/workflows/build-src-image.yml/badge.svg)](https://github.com/mbhangui/indimail-docker/actions/workflows/build--src-image.yml)
2. Build the final image by pulling the base images built and pushed in step 1. The dockerfiles come from [indimail-src](https://hub.docker.com/repository/docker/cprogrammer/indimail-src). [![status](https://github.com/mbhangui/indimail-docker/actions/workflows/build-bin-from-src.yml/badge.svg)](https://github.com/mbhangui/indimail-docker/actions/workflows/build-bin-from-src.yml)

tag|OS Distribution|indimai-mta|indimail|webmail
----|--------------|-----------|--------|-------
alpine|alpine Linux v3.15.x|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-alpine.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-alpine.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-alpine.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-alpine.yml)|TODO
gentoo|Gentoo|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-gentoo.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-gentoo.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-gentoo.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-gentoo.yml)|TODO
archlinux|Arch Linux|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-archlinux.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-archlinux.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-archlinux.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-archlinux.yml)|TODO
stream8|CentOS Stream 8|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-stream8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-stream8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-stream8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-stream8.yml)|TODO
stream9|CentOS Stream 9|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-stream9.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-stream9.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-stream9.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-stream9.yml)|TODO
ubi8|Redhat ubi8|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-ubi8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-mta-ubi8.yml)|[![ghcr build status](https://github.com/mbhangui/docker/actions/workflows/indimail-ubi8.yml/badge.svg)](https://github.com/mbhangui/docker/actions/workflows/indimail-ubi8.yml)|TODO


Let's say you want to use the **indimail** image and CentOS8

```
$ podman pull ghcr.io/mbhangui/indimail:stream8
Trying to pull ghcr.io/mbhangui/indimail:stream8...
Getting image source signatures
Copying blob 6910e5a164f7 skipped: already exists  
Copying blob 9c29f394b0db done  
Copying blob 6db186b8f3c7 [======>-------------------------------] 33.8MiB / 187.3MiB
Copying blob 6db186b8f3c7 done
Copying config e543dee69a done
Writing manifest to image destination
Storing signatures
e543dee69ab797c3a496295c96228265c45f5d221718a24ed8d230c5d79f943f
```

You can list the image using the `podman images` command

```
$ podman images
REPOSITORY                       TAG          IMAGE ID       CREATED        SIZE
ghcr.io/mbhangui/indimail        stream8      e543dee69ab7   38 hours ago   1.03 GB
ghcr.io/mbhangui/indimail        fc33         a5266643441b   4 days ago     1.13 GB
```

### Start the podman container

indimail, indimail-mta uses docker-entrypoint to execute svscan and start indimail-mta, indimail-mta. Passing webmail argument starts apache in addition to indimail. You just need to pass any argument other than indimail, indimail-mta, svscan or webmail to bypass the default action in docker-entrypoint.

The below command will start svscan process

```
$ podman run -d -h indimail.org --name indimail fba3b42e0164
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

The below command will execute bash instead of the default svscan process in the docker-entrypoint.

```
$ podman run -it --h indimail.org --name=indimail 4fce1055b1e7 bash
docker-entrypoint: executing bash
```

You can use --net host to map the container's network to the HOST

```
$ docker run --net host -d -h indimail.org --name indimail fba3b42e0164
or
$ podman run --net host -d -h indimail.org --name indimail fba3b42e0164
```

You can combine the pull and run in a single command. Below are 3 use cases of invocation.

```
1) Run the container in detached mode with systemd (init), just like a normal machine
   $ podman run -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
      --cap-add SYS_PTRACE --cap-add SYS_ADMIN --cap-add IPC_LOCK --cap-add SYS_RESOURCE \
      -d --rm -h indimail.org --name indimail \
      cprogrammer/indimail:stream8 /usr/lib/systemd/systemd

   Connect to the container
   ------------------------
   $ podman exec -ti indimail bash
   $ ps -ef

2) Run the container with just indimail with a controlling terminal and bash shell
   $ podman run -it --rm -h indimail.org --name indimail \
     ghcr.io/mbhangui/indimail:stream8 bash

   start indimail
   --------------
   $ /usr/libexec/indimail/svscanboot &
   $ ps -ef

3) Run the container with just indimail in detached mode and svscan running as PID 1
   The containers have been configured with 5 queues as default and hence you will
   see 5 qmail-send, qmail-lspawn, qmail-rspawn, qmail-lspawn

   $ podman run -d --rm -h indimail.org --name indimail \
     ghcr.io/mbhangui/indimail:stream8

   indimail.org:(root) / >ps -ef|egrep "svscan|qmail-send|qmail-smtpd|qmail-clean|spawn"
   root           1       0  0 17:23 ?        00:00:00 /usr/sbin/svscan /service
   root           2       1  0 17:23 ?        00:00:00 supervise log .svscan
   root          15       1  0 17:23 ?        00:00:00 supervise qmail-smtpd.587
   root          16       1  0 17:23 ?        00:00:00 supervise log qmail-smtpd.587
   qmaill        19       2  0 17:23 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/svscan
   root          32       1  0 17:23 ?        00:00:00 supervise qmail-send.25
   root          33       1  0 17:23 ?        00:00:00 supervise log qmail-send.25
   root          46       1  0 17:23 ?        00:00:00 supervise qmail-smtpd.25
   root          47       1  0 17:23 ?        00:00:00 supervise log qmail-smtpd.25
   root          48       1  0 17:23 ?        00:00:00 supervise qmail-smtpd.465
   root          49       1  0 17:23 ?        00:00:00 supervise log qmail-smtpd.465
   root          76       1  0 17:23 ?        00:00:00 supervise qmail-smtpd.366
   root          77       1  0 17:23 ?        00:00:00 supervise log qmail-smtpd.366
   indimail     110      76  0 17:23 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l indimail.org -x /etc/indimail/tcp/tcp.smtp.cdb -c variables/MAXDAEMONS -o -b 150 -u 555 -g 555 0 366 /usr/sbin/qmail-smtpd
   root         175      88  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   qmailr       176      88  0 17:23 ?        00:00:00 qmail-rspawn
   qmailq       177      88  0 17:23 ?        00:00:00 qmail-clean
   qmails       338     335  0 17:23 ?        00:00:00 qmail-send
   qmails       339     335  0 17:23 ?        00:00:00 qmail-send
   qmails       340     335  0 17:23 ?        00:00:00 qmail-send
   qmails       341     335  0 17:23 ?        00:00:00 qmail-send
   qmails       342     335  0 17:23 ?        00:00:00 qmail-send
   root         343     338  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   root         344     339  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   qmailr       345     338  0 17:23 ?        00:00:00 qmail-rspawn
   qmailr       346     339  0 17:23 ?        00:00:00 qmail-rspawn
   root         347     340  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   qmailq       348     338  0 17:23 ?        00:00:00 qmail-clean
   qmailr       349     340  0 17:23 ?        00:00:00 qmail-rspawn
   qmailq       350     339  0 17:23 ?        00:00:00 qmail-clean
   qmailq       352     340  0 17:23 ?        00:00:00 qmail-clean
   qmailq       354     338  0 17:23 ?        00:00:00 qmail-clean
   qmailq       356     339  0 17:23 ?        00:00:00 qmail-clean
   qmailq       357     340  0 17:23 ?        00:00:00 qmail-clean
   root         358     342  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   qmailr       359     342  0 17:23 ?        00:00:00 qmail-rspawn
   qmailq       360     342  0 17:23 ?        00:00:00 qmail-clean
   qmailq       362     342  0 17:23 ?        00:00:00 qmail-clean
   root         363     341  0 17:23 ?        00:00:00 qmail-lspawn ./Maildir/
   qmailr       364     341  0 17:23 ?        00:00:00 qmail-rspawn
   qmailq       365     341  0 17:23 ?        00:00:00 qmail-clean
   qmailq       367     341  0 17:23 ?        00:00:00 qmail-clean
   root         505     481  0 17:29 pts/0    00:00:00 grep -E --color=auto svscan|qmail-send|qmail-smtpd|qmail-clean|spawn
```

There are other cool things you can do with the docker/podman images. You can have the images have their own filesystem with the queue and the user's home directory. It is better to have them on the host running the containers.

### Creating podman volumes

The big advantage of using docker / podman container is the ease with which you can maintain your server config. You can easily make snapshots of the configuration, push the image to your own docker / podman repository, pull it whenever required and deploy with exactly the same configuration. You don't have to run custom scripts to configure your server. Now we need to decide few things. indimail / indimail-mta requires a filesystem for the queue and a filesystem to store the user's emails. We call it the `queue` directory and the `maildir` directory. i.e.

1. The mail queue denoted by `queue`
2. The user's mail directories denoted by `maildir`

These two directories change often and change continuously. You don't want the snapshots to take too long to complete. Hence it is best to have these two directories on your host rather than be a part of the container image. You can have it part of the container. But when you run the `podman commit` command, the changes to the container since you started it, will be huge. Hence the commit might take very long. It is best that you backup the queue and the maildir directories on the host itself. To achieve this you can do the following

```
$ podman volume create queue
queue
$ podman volume create mail
mail

$ docker run --net host -d -h indimail.org --name indimail \
    -v queue:/var/indimail/queue -v mail:/home fba3b42e0164
or
$ podman run --net host -d -h indimail.org --name indimail \
    -v queue:/var/indimail/queue -v mail:/home fba3b42e0164
```

If you do this way you will have to initialize the queue the first time.

```
$ podman exec -ti indimail bash
indimail.org:(root) / > cd /var/indimail/queue
indimail.org:(root) /var/indimail/queue > for i in 1 2 3 4 5 6
> do
> queue-fix queue"$i" >/dev/null
> done
indimail.org:(root) /var/indimail/queue >queue-fix nqueue
queue-fix finished...
indimail.org:(root) /var/indimail/queue >ls -l
total 24
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 nqueue
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 queue1
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 queue2
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 queue3
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 queue4
drwxr-x--- 12 qmailq qmail 4096 Jul  6 04:07 queue5
```

The volumes are created in your home directory. You can inspect them using the `podman volume inspect` command

```
$ podman volume inspect queue
[
     {
          "Name": "queue",
          "Driver": "local",
          "Mountpoint": "/home/mbhangui/.local/share/containers/storage/volumes/queue/_data",
          "CreatedAt": "2020-07-06T09:44:18.83317159+05:30",
          "Labels": {
               
          },
          "Scope": "local",
          "Options": {
               
          },
          "UID": 0,
          "GID": 0,
          "Anonymous": false
     }
]
$ cd /home/mbhangui/.local/share/containers/storage/volumes/queue/\_data
$ ls -l
total 24
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 nqueue
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 queue1
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 queue2
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 queue3
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 queue4
drwxr-x--- 12 101003 101000 4096 Jul  6 09:37 queue5
```

If you backup the user's home directory (e.g. /home/mbhangui), the backup will include /home/mail of the container. You can specifically take a backup of container's user mail directory by doing `podman volume inspect mail` and backup the directory referenced by `Mountpoint`.

There is an alternate way, without having podman volumes, to have the queue and the home directories on the host server. All you need to do is create directories on the host system.

**Create Directories**

You can create the queue and the maildir directories anywhere where you have space. These two could be on a separate filesystems or on the same filesystem. Below is a simple example where both have been created on the /home filesystem.

NOTE: every command is being done with your own non-privileged UNiX user id.

* Create the `queue` directory

```
$ mkdir -p /home/podman/queue
```

* Create the `maildir` directory

```
$ mkdir -p /home/podman/mail
```

Now we can start the container with the `podman run` command. Here podman mounts /home/podman/queue as /var/indimail/queue and /home/podman/mail as /home/mail. To backup the mail directory, you just need to backup /home/podman/mail. Like the previous examples where we used volumes, you will have to initialize the queue using the `queue-fix` command in /var/indimail/queue directory.

```
$ podman run -d -h indimail.org \
    -v /home/podman/queue:/var/indimail/queue \
    -v /home/podman/mail:/home/mail \
    --name indimail e543dee69ab7
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304
```

### Query the id of the container

```
$ podman ps
CONTAINER ID  IMAGE                                   COMMAND   CREATED             STATUS                 PORTS  NAMES
0deab2154ef8  ghcr.io/mbhangui/indimail:stream8  indimail  About a minute ago  Up About a minute ago         indimail
```

### Execute an interactive shell in the container

```
$ podman exec -ti indimail /bin/bash
indimail:/>
```

### Get processlist in the container

```
indimail:/> ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 13:39 ?        00:00:00 /usr/sbin/svscan /service
root           2       1  0 13:39 ?        00:00:00 supervise qmail-smtpd.587
root           3       1  0 13:39 ?        00:00:00 supervise log
root           4       1  0 13:39 ?        00:00:00 supervise qmail-pop3d.110
root           5       1  0 13:39 ?        00:00:00 supervise log
root           6       1  0 13:39 ?        00:00:00 supervise qmail-qmqpd.628
root           7       1  0 13:39 ?        00:00:00 supervise log
root           8       1  0 13:39 ?        00:00:00 supervise qmail-imapd.143
root           9       1  0 13:39 ?        00:00:00 supervise log
root          10       1  0 13:39 ?        00:00:00 supervise qmail-qmtpd.209
root          11       1  0 13:39 ?        00:00:00 supervise log
root          12       1  0 13:39 ?        00:00:00 supervise fetchmail
root          13       1  0 13:39 ?        00:00:00 supervise log
root          14       1  0 13:39 ?        00:00:00 supervise qscanq
root          15       1  0 13:39 ?        00:00:00 supervise log
root          16       1  0 13:39 ?        00:00:00 supervise qmail-poppass.106
root          17       1  0 13:39 ?        00:00:00 supervise log
root          18       1  0 13:39 ?        00:00:00 supervise libwatch
root          19       1  0 13:39 ?        00:00:00 supervise log
root          20       1  0 13:39 ?        00:00:00 supervise log
root          21       1  0 13:39 ?        00:00:00 supervise proxy-imapd-ssl.9143
root          22       1  0 13:39 ?        00:00:00 supervise log
root          23       1  0 13:39 ?        00:00:00 supervise qmail-send.25
root          24       1  0 13:39 ?        00:00:00 supervise log
root          25       1  0 13:39 ?        00:00:00 supervise proxy-pop3d-ssl.9110
root          26       1  0 13:39 ?        00:00:00 supervise log
root          27       1  0 13:39 ?        00:00:00 supervise qmail-logfifo
root          28       1  0 13:39 ?        00:00:00 supervise log
root          29       1  0 13:39 ?        00:00:00 supervise qmail-pop3d-ssl.995
root          30       1  0 13:39 ?        00:00:00 supervise log
qmaill        31       5  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/pop3d.110
root          32       1  0 13:39 ?        00:00:00 supervise qmail-smtpd.366
root          33       1  0 13:39 ?        00:00:00 supervise log
indimail      34       2  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l 0 -x /etc/indimail/tcp/tcp.smtp.cdb -c /service/q
root          35       1  0 13:39 ?        00:00:00 supervise udplogger.3000
root          36       1  0 13:39 ?        00:00:00 supervise log
root          37       1  0 13:39 ?        00:00:00 supervise mrtg
root          38       1  0 13:39 ?        00:00:00 supervise log
root          39       1  0 13:39 ?        00:00:00 supervise qmail-smtpd.25
root          40       1  0 13:39 ?        00:00:00 supervise log
root          41       1  0 13:39 ?        00:00:00 supervise proxy-pop3d.4110
root          42       1  0 13:39 ?        00:00:00 supervise log
indimail      43       4  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/qmail-pop3d.110/variables/MAXDAEMONS -C 25 -x 
root          44       1  0 13:39 ?        00:00:00 supervise mysql.3306
root          45       1  0 13:39 ?        00:00:00 supervise log
root          46       1  0 13:39 ?        00:00:00 supervise indisrvr.4000
root          47       1  0 13:39 ?        00:00:00 supervise log
root          48       1  0 13:39 ?        00:00:00 supervise qmail-daned.1998
root          49       1  0 13:39 ?        00:00:00 supervise log
root          50       1  0 13:39 ?        00:00:00 supervise pwdlookup
root          51       1  0 13:39 ?        00:00:00 supervise log
qscand        52      14  0 13:39 ?        00:00:00 /usr/sbin/cleanq -l -s 200 /var/indimail/qscanq/root/scanq
root          53      18  0 13:39 ?        00:00:00 /bin/sh ./run
qmaill        54       3  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/smtpd.587
root          55       1  0 13:39 ?        00:00:00 supervise greylist.1999
root          56       1  0 13:39 ?        00:00:00 supervise log
qmaill        57       9  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/imapd.143
qmaill        58       7  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/qmqpd.628
root          59       1  0 13:39 ?        00:00:00 supervise qmail-smtpd.465
root          60       1  0 13:39 ?        00:00:00 supervise log
indimail      61      10  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l 0 -x /etc/indimail/tcp/tcp.qmtp.cdb -c /service/q
root          62       1  0 13:39 ?        00:00:00 supervise proxy-imapd.4143
root          63       1  0 13:39 ?        00:00:00 supervise log
indimail      64      16  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l 0 -x /etc/indimail/tcp/tcp.poppass.cdb -X -c /ser
root          65       1  0 13:39 ?        00:00:00 supervise inlookup.infifo
root          66       1  0 13:39 ?        00:00:00 supervise log
qmaill        67      15  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/qscanq
root          68       1  0 13:39 ?        00:00:00 supervise qmail-imapd-ssl.993
root          69       1  0 13:39 ?        00:00:00 supervise log
qmaill        70      19  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/libwatch
qmaill        71      11  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/qmtpd.209
indimail      72       8  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/qmail-imapd.143/variables/MAXDAEMONS -C 25 -x 
indimail      73      21  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/proxy-imapd-ssl.9143/variables/MAXDAEMONS -C 2
qmaill        74      17  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/poppass.106
qmaill        75      24  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/deliver.25
qmaill        76      20  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/svscan
qmaill        77      22  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/proxyIMAP.9143
root          78      23  0 13:39 ?        00:00:00 qmail-daemon ./Maildir/
qmaill        79      26  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/proxyPOP3.9110
qmaill        80      13  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/fetchmail
indimail      81      25  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/proxy-pop3d-ssl.9110/variables/MAXDAEMONS -C 2
indimail      82      27  0 13:39 ?        00:00:00 /usr/bin/qmail-cat /tmp/logfifo
qmaill        83      30  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/pop3d-ssl.995
qmaill        84      28  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/logfifo
qmaill        85      36  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/udplogger.3000
indimail      86      32  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l 0 -x /etc/indimail/tcp/tcp.smtp.cdb -c /service/q
qmaill        87      33  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/smtpd.366
indimail      88      35  0 13:39 ?        00:00:00 /usr/sbin/udplogger -p 3000 -t 10 0
indimail      89      41  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/proxy-pop3d.4110/variables/MAXDAEMONS -C 25 -x
root          90      37  0 13:39 ?        00:00:00 /bin/sh ./run
qmaill        91      38  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/mrtg
indimail      92      39  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -h -R -l 0 -x /etc/indimail/tcp/tcp.smtp.cdb -c /service/q
qmaill        93      40  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/smtpd.25
qmaill        94      42  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/proxyPOP3.4110
indimail      96      29  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/qmail-pop3d-ssl.995/variables/MAXDAEMONS -C 25
qmaill        97      45  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/mysql.3306
indimail      98      48  0 13:39 ?        00:00:00 /usr/sbin/qmail-daned -w /etc/indimail/control/tlsa.white -t 30 -s 5 -h 65535 12
qmaill        99      49  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/daned.1998
indimail     101      46  0 13:39 ?        00:00:00 /usr/sbin/indisrvr -i 0 -p 4000 -b 40 -n /etc/indimail/certs/servercert.pem
indimail     104      50  0 13:39 ?        00:00:00 /usr/sbin/nssd -d notice
qmaill       105      47  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/indisrvr.4000
qmaill       106      51  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/pwdlookup
indimail     107      55  0 13:39 ?        00:00:00 /usr/sbin/qmail-greyd -w /etc/indimail/control/greylist.white -t 30 -g 24 -m 2 -
qmaill       108      56  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/greylist.1999
qmaill       109      60  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/smtpd.465
indimail     112      59  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -h -R -l 0 -x /etc/indimail/tcp/tcp.smtp.cdb -c /service/q
indimail     113      62  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/proxy-imapd.4143/variables/MAXDAEMONS -C 25 -x
indimail     114      68  0 13:39 ?        00:00:00 /usr/bin/tcpserver -v -c /service/qmail-imapd-ssl.993/variables/MAXDAEMONS -C 25
qmaill       115      69  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/imapd-ssl.993
qmaill       116      66  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/inlookup.infifo
qmaill       117      63  0 13:39 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/proxyIMAP.4143
root         154      53  0 13:39 ?        00:00:00 /usr/bin/inotify -n /usr/lib64
root         155      53  1 13:39 ?        00:00:00 /bin/sh ./run
qmails       162      78  0 13:39 ?        00:00:00 qmail-send
qmails       163      78  0 13:39 ?        00:00:00 qmail-send
qmails       166      78  0 13:39 ?        00:00:00 qmail-send
qmails       168      78  0 13:39 ?        00:00:00 qmail-send
qmails       169      78  0 13:39 ?        00:00:00 qmail-send
root         171     163  0 13:39 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       172     163  0 13:39 ?        00:00:00 qmail-rspawn
qmailq       173     163  0 13:39 ?        00:00:00 qmail-clean
qmails       174     163  0 13:39 ?        00:00:00 qmail-todo
qmailq       175     163  0 13:39 ?        00:00:00 qmail-clean
root         177     162  0 13:39 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       178     162  0 13:39 ?        00:00:00 qmail-rspawn
qmailq       179     162  0 13:39 ?        00:00:00 qmail-clean
qmails       180     162  0 13:39 ?        00:00:00 qmail-todo
qmailq       181     162  0 13:39 ?        00:00:00 qmail-clean
root         182     166  0 13:39 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       183     166  0 13:39 ?        00:00:00 qmail-rspawn
qmailq       184     166  0 13:39 ?        00:00:00 qmail-clean
qmails       185     166  0 13:39 ?        00:00:00 qmail-todo
qmailq       186     166  0 13:39 ?        00:00:00 qmail-clean
root         188     168  0 13:39 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       189     168  0 13:39 ?        00:00:00 qmail-rspawn
qmailq       190     168  0 13:39 ?        00:00:00 qmail-clean
qmails       191     168  0 13:39 ?        00:00:00 qmail-todo
qmailq       192     168  0 13:39 ?        00:00:00 qmail-clean
root         197     169  0 13:39 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       198     169  0 13:39 ?        00:00:00 qmail-rspawn
qmailq       199     169  0 13:39 ?        00:00:00 qmail-clean
qmails       200     169  0 13:39 ?        00:00:00 qmail-todo
qmailq       201     169  0 13:39 ?        00:00:00 qmail-clean
root         284      90  0 13:39 ?        00:00:00 sleep 300
root         301       0  0 13:39 pts/0    00:00:00 /bin/bash
mysql        353      44 48 13:40 ?        00:00:02 /usr/sbin/mysqld --defaults-file=/etc/indimail/indimail.cnf --port=3306 --basedi
indimail     406      65  0 13:40 ?        00:00:00 /usr/sbin/inlookup -i 5 -c 5184000
root         407     301  0 13:40 pts/0    00:00:00 ps -ef
indimail:/> exit
```

NOTE: The ps list has been deliberately truncated to keep the size of this document small.

Now we create a IndiMail virtual domain example.com. The `pass` parameter is the password of the postmaster user. It can be used to connect the the postmaster account using IMAP or POP3 with that password.

```
indimail.org:(root) / > vadddomain example.com pass 
Adding alias abuse@example.com --> postmaster@example.com
Adding alias mailer-daemon@example.com --> postmaster@example.com
Sending SIGHUP to /service/qmail-smtpd.25
Sending SIGHUP to /service/qmail-smtpd.465
Sending SIGHUP to /service/qmail-smtpd.587
Sending SIGHUP to /service/inlookup.infifo
Sending SIGHUP to /service/qmail-send.25
---- Domain example.com               -------------------------------
    domain: example.com
       uid: 555
       gid: 555
Domain Dir: /var/indimail/domains/example.com
  Base Dir: /home/mail
Dir Control     = /home/mail/L2P
cur users       = 1
dir prefix      = 
Users per level = 100
level_cur       = 0
level_max       = 3
level_index 0   = 0
            1   = 0
            2   = 0
level_start 0   = 0
            1   = 0
            2   = 0
level_end   0   = 61
            1   = 61
            2   = 61
level_mod   0   = 0
            1   = 2
            2   = 4

     Users: 1
   vlimits: disabled
Creating standard users for spam filter (bogofilter)
name          : prefilt@example.com
passwd        : xxxxxxxx (DES)
uid           : 1
gid           : 0
                -all services available
gecos         : prefilt
dir           : /home/mail/L2P/example.com/prefilt
quota         : 524288000 [500.00 MiB]
curr quota    : 0S,0C
Mail Store IP : 127.0.0.1 (NonClustered - local
Mail Store ID : non-clustered domain
Sql Database  : localhost
Unix   Socket : /var/run/mysqld/mysqld.sock
Table Name    : indimail
Relay Allowed : NO
Days inact    : 0 Secs
Added On      : (127.0.0.1) Thu Jun 25 07:56:55 2020
last  auth    : Not yet logged in
last  IMAP    : Not yet logged in
last  POP3    : Not yet logged in
PassChange    : Not yet Changed
Inact Date    : Not yet Inactivated
Activ Date    : (127.0.0.1) Thu Jun 25 07:56:55 2020
Delivery Time : No Mails Delivered yet / Per Day Limit not configured
name          : postfilt@example.com
passwd        : xxxxxxxx (DES)
uid           : 1
gid           : 0
                -all services available
gecos         : postfilt
dir           : /home/mail/L2P/example.com/postfilt
quota         : 524288000 [500.00 MiB]
curr quota    : 0S,0C
Mail Store IP : 127.0.0.1 (NonClustered - local
Mail Store ID : non-clustered domain
Sql Database  : localhost
Unix   Socket : /var/run/mysqld/mysqld.sock
Table Name    : indimail
Relay Allowed : NO
Days inact    : 0 Secs
Added On      : (127.0.0.1) Thu Jun 25 07:56:55 2020
last  auth    : Not yet logged in
last  IMAP    : Not yet logged in
last  POP3    : Not yet logged in
PassChange    : Not yet Changed
Inact Date    : Not yet Inactivated
Activ Date    : (127.0.0.1) Thu Jun 25 07:56:55 2020
Delivery Time : No Mails Delivered yet / Per Day Limit not configured
creating rules for spam, virus detected emails
drwxr-x--- 2 indimail indimail 4096 Jun 25 07:56 /var/indimail/domains/example.com
total 16
drwxr-x--- 2 indimail indimail 4096 Jun 25 07:56 .
drwxrwxr-x 4 root     indimail 4096 Jun 25 07:56 ..
-rw-r----- 1 indimail indimail   15 Jun 25 07:56 .filesystems
-rw-rw---- 1 indimail indimail   46 Jun 25 07:56 .qmail-default
adding example.com to spamignore control file
adding example.com to nodnscheck control file
```

Let us now send an email to this account

```
indimail.org:(root) / > echo "testing email to postmaster" | mail -s "Test Email" postmaster@example.com
indimail.org:(root) / > tail -20 /var/log/svc/deliver.25/current 
2020-06-25 07:50:42.582514500 qmail-daemon: qStart/qCount 1/5
2020-06-25 07:50:42.585980500 qmail-daemon: pid 187, queue /var/indimail/queue/queue1 started
2020-06-25 07:50:42.586586500 qmail-daemon: pid 188, queue /var/indimail/queue/queue2 started
2020-06-25 07:50:42.587227500 qmail-daemon: pid 189, queue /var/indimail/queue/queue3 started
2020-06-25 07:50:42.587839500 qmail-daemon: pid 190, queue /var/indimail/queue/queue4 started
2020-06-25 07:50:42.588521500 qmail-daemon: pid 191, queue /var/indimail/queue/queue5 started
2020-06-25 07:50:42.855081500 status: local 0/10 remote 0/20 queue2
2020-06-25 07:50:42.860865500 status: local 0/10 remote 0/20 queue5
2020-06-25 07:50:42.903783500 status: local 0/10 remote 0/20 queue4
2020-06-25 07:50:42.925976500 status: local 0/10 remote 0/20 queue1
2020-06-25 07:50:42.937832500 status: local 0/10 remote 0/20 queue3
2020-06-25 08:00:09.681525500 new msg 100926020 queue5
2020-06-25 08:00:09.681533500 info msg 100926020: bytes 814 from <root@indimail.org> qp 555 uid 0 queue5
2020-06-25 08:00:09.682393500 local: root@indimail.org postmaster@example.com 814 queue5
2020-06-25 08:00:09.682401500 starting delivery 1: msg 100926020 to local example.com-postmaster@example.com queue5
2020-06-25 08:00:09.682407500 status: local 1/10 remote 0/20 queue5
2020-06-25 08:00:09.713833500 delivery 1: success: did_0+0+1/ queue5
2020-06-25 08:00:09.718460500 status: local 0/10 remote 0/20 queue5
2020-06-25 08:00:09.718523500 end msg 100926020 queue5
```

We can retrieve or read the email using POP3 or IMAP

```
indimail.org:(root) / > telnet 0 110
Trying 0.0.0.0...
Connected to 0.
Escape character is '^]'.
+OK POP3 Server Ready.
user postmaster@example.com
+OK Password required.
pass pass
+OK logged in.
list
+OK POP3 clients that break here, they violate STD53.
1 1004
.
retr 1
+OK 1004 octets follow.
Return-Path: <root@indimail.org>
Delivered-To: example.com-postmaster@example.com
X-Filter: None
Received: (indimail 557 invoked by uid 555); Thu Jun 25 08:00:09 2020
Received: (indimail-mta 555 invoked by uid 0); Thu, 25 Jun 2020 08:00:09 +0000
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;
 d=indimail.org; s=default; x=1593676809; h=Message-ID:From:Date:
 To:Subject:User-Agent:MIME-Version:Content-Type:
 Content-Transfer-Encoding; bh=6hp9qseDUIP2i1ZogtcVM/Y6sE4=; b=Ky
 cnt77fJ2KsygcFF1cOh+CzGHGglCaKj7riudZca3KY11++XZW0X5SrbAqY7tzW3l
 90Kc5oORTKkM1dYnVhqCskQd2GiQgiek7/ykcjnINsGln/Zp+at/LKZ4ga2GblKO
 b3TNlrzzWapsprtoGGIlcTF+/X4qOqUSbkcdOHBtE=
Message-ID: <20200625080009.550.indimail@indimail.org>
From: root@indimail.org
Date: Thu, 25 Jun 2020 08:00:09 +0000
To: postmaster@example.com
Subject: Test Email
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

testing email to postmaster
.
quit
+OK Phir Kab Miloge?
Connection closed by foreign host.
```

The image that we pulled sets the hostname as indimail.org (`-h` argument when we ran the `podman run` command). Also the docker images have been configured with `indimail.org` as the hostname. We will now change this configuration and commit the image.

```
# find the list of files having indimail.org

indimail.org:(root) / > cd /var/indimail
indimail.org:(root) /var/indimail/control > find . -type f -exec grep -l indimail.org {} \;
./me
./envnoathost
./smtpgreeting
./defaultdomain
./defaulthost
./nodnscheck
./rcpthosts
./plusdomain
./locals

# Now let us change indimail.org to mydomain.com

indimail.org:(root) /var/indimail/control > for i in `find . -type f -exec grep -l indimail.org {} \;`
> do
> sed -i -e 's{indimail.org{mydomain.com{' $i
> done
indimail.org:(root) /var/indimail/control >

# send qmail-send a sighup

indimail.org:(root) /var/indimail/control > svc -h /service/qmail-send.25

```

We have changed the configuration of the indimail container above. We can quit the container by exiting the shell or open another terminal and run the following command on the original host (not on the container).

```
$ podman commit indimail mycontainer
Getting image source signatures
Copying blob eb29745b8228 skipped: already exists  
Copying blob 145f10c50be1 skipped: already exists  
Copying blob 0b76d212b7b9 skipped: already exists  
Copying blob ff006700b93b done  
Copying config 7bcf4b2ff8 done  
Writing manifest to image destination
Storing signatures
7bcf4b2ff83e599d6ca8176f53fd7b0f24412d6f4f0c021f00310ed281477ca3

$ podman images
REPOSITORY                       TAG          IMAGE ID       CREATED          SIZE
localhost/mycontainer            latest       7bcf4b2ff83e   53 seconds ago   1.16 GB
ghcr.io/mbhangui/indimail        stream8      e543dee69ab7   39 hours ago     1.03 GB
ghcr.io/mbhangui/indimail        fc31         a5266643441b   4 days ago       1.13 GB
```

The original container is now longer needed to run. We can stop it and remove the image from memory

```
$ podman stop indimail
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304

$ podman rm indimail
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304
```

You can now use the container with id `7bcf4b2ff83e` to run the indimail server with mydomain.org as the domain.

I use [this](https://github.com/mbhangui/docker/blob/master/runpod) script to run my indimail containers. It should be invoked like this

```
$ runpod --id=7bcf4b2ff83e --name=indimail --host=mydomain.org --args="-d"
podman run -d 
    --name indimail
    --cap-add SYS_PTRACE --cap-add SYS_ADMIN --cap-add IPC_LOCK   --cap-add SYS_RESOURCE
    -h mydomain.org
    -p 2025:25   -p 2106:106  -p 2110:110  -p 2143:143 -p 2209:209  -p 2366:366  -p 2465:465  -p 2587:587 -p 2628:628  -p 2993:993  -p 2995:995  -p 4110:4110 -p 4143:4143 -p 9110:9110 -p 9143:9143 -p 8080:80
    -v queue:/var/indimail/queue -v mail:/home 
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro
    --device /dev/fuse
    image=7bcf4b2ff83e systemd=/usr/lib/systemd/systemd
471b4e53020b350c5e62e4913fe815203d16827e3e6cfc5e14fced8579c4a2b3
```

The argument --name=indimail is needed. It is actually an entry point in all the indimail, indimail-mta containers to start `svscan` command. The `svscan` command further runs `supervise` command on all services in the `/service` directory. Similarly the `indimail-web` container images have the entry point `webmail` which does everything that `indimail` entrypoint does and addiotionally runs the `apache` web server.

If you use this script it will

1. mount mail volume as the /home, queue volume as the /var/indimail/queue
2. Map high number ports on the host to low number ports on the container. If you want to map low number ports or to map the same ports (like port 25 on the host to be mapped to port 25 on the container), you will have to run podman with root privileges. You can map high number ports and set **iptable**(8) rules to map the same ports on the host system to a port on the container. If you run podman with root privileges, you can use --net host to map the container's network to the HOST. In that case you don't have to map the ports using the `-p` argument.
3. Use the [docker entrypoint](https://docs.docker.com/engine/reference/builder/#entrypoint) **indimail** to start all indimail services.
4. Run the container with special privileges that allows it to start like a normal OS with systemd, privileges to do strace and IPC locking


### Stop the container

```
$ podman stop \`podman ps -q\`
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

### Clear the stopped container image

```
$ podman rm \`podman ps -aq\`
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

## github respository for Dockerfile

The Dockerfile for each of the images is located in a separate subdirectory for each linux distro

* [indimail-mta](https://github.com/mbhangui/docker/tree/master/indimail-mta)
* [indimail](https://github.com/mbhangui/docker/tree/master/indimail)
* [indimail+roundcube](https://github.com/mbhangui/docker/tree/master/webmail)



```
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
```

To build the image use need to use the docker/podman build command .e.g.

```
$ docker build -t indimail:fc31 ./Dockerfile .
or
$ podman build -t indimail:fc31 ./Dockerfile .
```
### Building container images

If may want to build the image yourself instead of using ghcr.io. All you need is the Dockerfile and the files .alias, .bash_profile, .bashrc, .exrc, .gfuncs, .glogout, .indent.pro, .vimrc.

The Dockerfile for each of the images is located in a separate subdirectory for each linux distro

* [indimail-mta](https://github.com/mbhangui/docker/tree/master/indimail-mta)
* [indimail](https://github.com/mbhangui/docker/tree/master/indimail)
* [indimail+roundcube](https://github.com/mbhangui/docker/tree/master/webmail)


To build the image ensure that you create a build directory and copy Dockerfile and .alias, .bash_profile, .bashrc, .exrc, .gfuncs, .glogout, .indent.pro, .vimrc to the build directory

```
$ mkdir -p /usr/local/src
$ cd /usr/local/src
# let us say you want to build the alpine image for indimail-mta
$ git clone https://github.com/mbhangui/docker.git
$ cd docker
$ cp indimail-mta/alpine/Dockerfile .

for building a docker container use

$ docker build -t localhost/indimail-mta:alpine .

for building a podman container use

$ podman build -t localhost/indimail-mta:alpine .

You can use the docker images or podman images command to list the container images

$ podman images
REPOSITORY                                 TAG         IMAGE ID      CREATED         SIZE
ghcr.io/mbhangui/indimail-mta              stream8     108c6e83242e  2 hours ago     717 MB
ghcr.io/mbhangui/indimail-mta              hirsute     bf58434c3a76  3 hours ago     347 MB
ghcr.io/mbhangui/indimail                  alpine      62f9d0d95427  15 hours ago    468 MB
localhost/indimail                         alpine      62f9d0d95427  15 hours ago    468 MB
ghcr.io/mbhangui/indimail-mta              alpine      0dffb4b398af  28 hours ago    404 MB
localhost/indimail-mta                     alpine      0dffb4b398af  28 hours ago    404 MB
ghcr.io/mbhangui/tinydnssec                alpine      dc1c37c76a50  41 hours ago    97.2 MB
localhost/tinydnssec                       alpine      dc1c37c76a50  41 hours ago    97.2 MB
registry.access.redhat.com/rhel7           latest      538460c14d75  2 weeks ago     216 MB
localhost/indimail-mta                     tumbleweed  999a86c2bc61  2 weeks ago     413 MB
localhost/indimail-mta                     leap15.3    899596f466a1  2 weeks ago     500 MB
localhost/indimail-mta                     debian10    f3a8194282d7  3 weeks ago     306 MB
registry.opensuse.org/opensuse/leap        15.3        accc3d285fe7  4 weeks ago     108 MB
registry.opensuse.org/opensuse/leap        latest      accc3d285fe7  4 weeks ago     108 MB
docker.io/library/almalinux                8           7a497d63e726  4 weeks ago     216 MB
docker.io/library/debian                   10          7a4951775d15  5 weeks ago     119 MB
docker.io/library/ubuntu                   hirsute     093da574621d  5 weeks ago     82.9 MB
docker.io/library/alpine                   latest      d4ff818577bc  6 weeks ago     5.87 MB
registry.fedoraproject.org/fedora          34          abec9a7a7dc6  6 weeks ago     184 MB
docker.io/library/almalinux                latest      11c550a4f6c5  8 weeks ago     216 MB
docker.io/gentoo/stage3                    latest      e95526ecc92d  3 months ago    919 MB
docker.io/library/archlinux                latest      3de742be9254  4 months ago    416 MB
docker.io/library/debian                   8           3aaeab7a4777  4 months ago    135 MB
k8s.gcr.io/pause                           3.5         ed210e3e4a5b  4 months ago    690 kB
registry.opensuse.org/opensuse/tumbleweed  latest      cdd77ba4b087  4 months ago    94.7 MB
docker.io/library/oraclelinux              8           f4a1f2c861ca  6 months ago    436 MB
docker.io/library/ubuntu                   focal       f643c72bc252  8 months ago    75.3 MB
docker.io/library/ubuntu                   bionic      2c047404e52d  8 months ago    65.6 MB
docker.io/library/fedora                   33          b3048463dcef  8 months ago    181 MB
docker.io/opensuse/tumbleweed              latest      2eac6045a15c  8 months ago    93.4 MB
```

## NOTE

The images above have been installed without clam anti-virus to keep the image size as low as possible. You may install and configure it using the below steps.

```
$ sudo dnf -y install clamav clamav-update clamd # use apt-get for ubuntu/debian, zypper for openSUSE
$ sudo svctool --clamd --clamdPrefix=/usr --servicedir=/service --sysconfdir=/etc/clamd.d
$ sudo svctool --config=clamd
$ sudo svctool --config=foxhole
```

The images are without man pages. You do the following

```
On Debian
# apt-get install man-db

On Fedora/CentOS/Oracle Linux

# yum/dnf --setopt=tsflags=''
# yum/dnf install man-db man-pages

On openSUSE
# zypper install man man-pages
```

# SUPPORT INFORMATION

## IRC / Matrix

![Matrix](https://img.shields.io/matrix/indimail:matrix.org)

* [Matrix Invite Link #indimail:matrix.org](https://matrix.to/#/#indimail:matrix.org)
* IndiMail has an [IRC channel on libera](https://libera.chat/) #indimail-mta

The matrix room and libera.chat channel have been bridged so joining either one should be sufficient.

## Mailing list

There are four Mailing Lists for IndiMail

1. indimail-support  - You can subscribe for Support [here](https://lists.sourceforge.net/lists/listinfo/indimail-support). You can mail [indimail-support](mailto:indimail-support@lists.sourceforge.net) for support Old discussions can be seen [here](https://sourceforge.net/mailarchive/forum.php?forum_name=indimail-support)
2. indimail-devel - You can subscribe [here](https://lists.sourceforge.net/lists/listinfo/indimail-devel). You can mail [indimail-devel](mailto:indimail-devel@lists.sourceforge.net) for development activities. Old discussions can be seen [here](https://sourceforge.net/mailarchive/forum.php?forum_name=indimail-devel)
3. indimail-announce - This is only meant for announcement of New Releases or patches. You can subscribe [here](http://groups.google.com/group/indimail)
4. Archive at [Google Groups](http://groups.google.com/group/indimail). This groups acts as a remote archive for indimail-support and indimail-devel.

There is also a [Project Tracker](http://sourceforge.net/tracker/?group_id=230686) for IndiMail (Bugs, Feature Requests, Patches, Support Requests)

## References

1. [Super-Slim Docker Containers](https://medium.com/better-programming/super-slim-docker-containers-fdaddc47e560)
2. [Rootless containers with Podman: The basics](https://developers.redhat.com/blog/2020/09/25/rootless-containers-with-podman-the-basics#why_containers_)
3. [Using volumes with rootless podman, explained](https://www.tutorialworks.com/podman-rootless-volumes/)
4. [Podman User Guid](https://docs.oracle.com/en/operating-systems/oracle-linux/podman/index.html)
5. [Managing Containers](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/managing_containers/index)
6. [A Practical Introduction to Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction)
7. [Demystifying the Open Container Initiative (OCI) Specifications](https://www.docker.com/blog/demystifying-open-container-initiative-oci-specifications/)
