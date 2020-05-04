# Dockerfile repository for automated builds.

This repo contains repository for Dockerfiles used for building
docker/podman images for indimail-mta, indimail and  indimail with
roundcube webfrontend at

**indimail-mta**
https://hub.docker.com/r/cprogrammer/indimail-mta

**indimail**
https://hub.docker.com/r/cprogrammer/indimail

**indimail+roundcube **
https://hub.docker.com/r/cprogrammer/indimail-web


The following tags/images can be pulled by executing
the commands

## a) docker

```
docker pull cprogrammer/indimail-mta:tag
docker pull cprogrammer/indimail:tag
docker pull cprogrammer/webmail:tag
```

or

## b) podman

```
podman pull cprogrammer/indimail:tag
podman pull cprogrammer/indimail-mta:tag
```

Replace tag in the above command with one of the following
```
xenial     for Ubuntu 16.04
bionic     for Ubuntu 18.04
focal      for Ubuntu 20.04
centos7    for CentOS 7
centos8    for CentOS 8
debian8    for Debian 8
debian9    for Debian 9
debian10   for Debian 10
fc31       for Fedora Core 31
fc32       for Fedora Core 32
Tumbleweed for openSUSE Tumbleweed
Leap15.2   for openSUSE Leap 15.2
```

## Instructions for starting the docker/podman container
(replace podman with docker for docker operations)


### list podman images

$ podman images
```
REPOSITORY                                 TAG       IMAGE ID       CREATED       SIZE
docker.io/cprogrammer/indimail             centos7   fba3b42e0164   5 hours ago   2.9 GB
docker.io/cprogrammer/indimail             fc31      a5266643441b   4 days ago    1.13 GB
```

### Start the podman container

indimail, indimail-mta uses docker-entrypoint to execute svscan and start indimail-mta, indimail-mta. You just need to pass any argument other than indimail, indimail-mta, svscan or webmail to bypass the default entrypoint. Passing webmail argument starts apache in addition to indimail.

$ podman run -d -h indimail.org --name indimail fba3b42e0164
```
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

You can use --net host to map the container's network to the HOST
```
$ docker run --net host -d -h indimail.org --name indimail fba3b42e0164
or
$ podman run --net host -d -h indimail.org --name indimail fba3b42e0164
```

### Query the id of the container

$ podman ps
```
CONTAINER ID  IMAGE                                   COMMAND   CREATED             STATUS                 PORTS  NAMES
08a4df5054d9  docker.io/cprogrammer/indimail:centos7  indimail  About a minute ago  Up About a minute ago         indimail
```

### Execute an interactive shell in the container

$ podman exec -ti indimail /bin/bash
```
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

### Stop the container

$ podman stop \`podman ps -q\`
```
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

### Clear the stopped container image

$ podman rm \`podman ps -aq\`
```
08a4df5054d920cfdf8869aa777a7afc39bab19591394ea283c0c082f8b0a876
```

## c) github respository for Dockerfile

The Dockerfile for each of the images is located in a separate subdirectory for each linux distro

**indimail-mta**
https://github.com/mbhangui/docker/tree/master/indimail-mta

**indimail**
https://github.com/mbhangui/docker/tree/master/indimail

**indimail+roundcube**
https://github.com/mbhangui/docker/tree/master/webmail


If you want to build the image yourself instead of using hub.docker.com, ensure that you remove the below line from your Dockerfile

```
COPY .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc /root/
```

To build the image use need to use the docker/podman build command .e.g.
```
$ docker build -t indimail:fc31 ./Dockerfile .
or
$ podman build -t indimail:fc31 ./Dockerfile .
```

## NOTE
The images above have been installed without clam anti virus to keep the image size as low as possible. You may install and configure it using the below steps.
```
$ sudo dnf -y install clamav clamav-update clamd # use apt-get for ubuntu/debian, zypper for openSUSE
$ sudo svctool --clamd --clamdPrefix=/usr --servicedir=/service --sysconfdir=/etc/clamd.d
$ sudo svctool --config=clamd
$ sudo svctool --config=foxhole
```
