# Dockerfile repository for indimail, indimail-mta

This repo contains repository for Dockerfiles used for building docker/podman images for [indimail-mta](https://github.com/mbhangui/indimail-mta), [indimail](https://github.com/mbhangui/indimail-virtualdomains) and [indimail](https://github.com/mbhangui/indimail-virtualdomains) with [roundcube](https://roundcube.net/) web frontend. Read this document on how to run a fully functional mail server using docker / podman images. In just less than an hour, you will read how to run an indimail container and the bonus will be that you will understand how docker and podman works.

You can use either docker or podman. One of the downsides of Docker is it has a central daemon that runs as the root user, and this has security implications. But this is where Podman comes in handy. Podman is a [daemonless container engine](https://podman.io/) for developing, managing, and running OCI Containers on your Linux system in root or rootless mode. The complete set of instructions for installing podman is given [here](https://podman.io/getting-started/installation.html). If you decide to use docker, the complet set of instructions for installing docker is given [here](https://docs.docker.com/engine/install/).

You have to decide the image that you want.

* indimail-mta - for a minimal server that gives you a MTA. This server can receive mails from the internet and send mails to users within the same server or to the internet.
* indimail - For a complete mail server. You can create many virtual domains, access the mails using IMAP or POP3 and all everything that the **indimail-mta** image does.
* indimail-web - Like the **indimail** image with the addition of a web based email client based on [Roundcube Mail](https://roundcube.net/).


### Building container images

You need to have docker or podman installed. Installation of docker or podman is beyond the scope of this document. But you can refer to the official documents for installing docker or podman. Just google and you will know how to do that.

The Dockerfile for each of the images is located in a separate subdirectory for each linux distro

* [indimail-mta](https://github.com/mbhangui/docker/tree/master/indimail-mta)
* [indimail](https://github.com/mbhangui/docker/tree/master/indimail)
* [indimail+roundcube](https://github.com/mbhangui/docker/tree/master/webmail)


To build the image ensure that you create a build directory and copy the Docker file and .alias, .bash_profile, .bashrc, .exrc, .gfuncs, .glogout, .indent.pro, .vimrc

```
$ mkdir -p /usr/local/src
$ cd /usr/local/src
# let us say you want to build the alpine image for indimail-mta
$ git clone https://github.com/mbhangui/docker.git
$ cd docker/indimail-mta/alpine
$ for i in .alias .bash_profile .bashrc .exrc .gfuncs .glogout .indent.pro .vimrc; do cp ../../$i .; done

for building a docker container use

$ docker build -t localhost/indimail-mta:alpine .

for building a podman container use

$ podman build -t localhost/indimail-mta:alpine .

You can use the docker images or podman images command to list the container images

$ podman images
REPOSITORY                       TAG          IMAGE ID       CREATED          SIZE
localhost/mycontainer            latest       7bcf4b2ff83e   53 seconds ago   1.16 GB
docker.io/cprogrammer/indimail   centos8      e543dee69ab7   39 hours ago     1.03 GB
docker.io/cprogrammer/indimail   centos7      fba3b42e0164   5 hours ago      2.9 GB
docker.io/cprogrammer/indimail   fc31         a5266643441b   4 days ago       1.13 GB
```

### Start the podman container

indimail, indimail-mta uses docker-entrypoint to execute svscan and start indimail-mta, indimail-mta. Passing webmail argument starts apache in addition to indimail. You just need to pass any argument other than indimail, indimail-mta, svscan or webmail to bypass the default action in docker-entrypoint.

The below command will start svscan process. In the earlier `podman images` command we listed the images that we have built. When we want to run a container, we need to pass the **IMAGE ID** to the docker or podman command. e.g. `fba3b42e0164` is the image id of the indimail container that we have for centos7.

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
$ cd /home/mbhangui/.local/share/containers/storage/volumes/queue/_data
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
0deab2154ef8  docker.io/cprogrammer/indimail:centos8  indimail  About a minute ago  Up About a minute ago         indimail
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
docker.io/cprogrammer/indimail   centos8      e543dee69ab7   39 hours ago     1.03 GB
docker.io/cprogrammer/indimail   centos7      fba3b42e0164   5 hours ago      2.9 GB
docker.io/cprogrammer/indimail   fc31         a5266643441b   4 days ago       1.13 GB
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

## NOTE

The images above have been installed without clam anti virus to keep the image size as low as possible. You may install and configure it using the below steps.

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
