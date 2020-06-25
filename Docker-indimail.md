# IndiMail / indimail-mta in a docker / podman container

You would have already read the [document](README.md) on obtaining the podman images for IndiMail/indimail-mta from the [Docker Hub Repository](https://hub.docker.com/repositories). We will now speak about how to setup a complete mail server using one of these images.

## Installing Podman

The complete set of installing podman is given [here](https://podman.io/getting-started/installation.html).

## Downloading a docker / podman image

You have to decide the image that you would like to use.

* indimail-mta - for a minimal server that gives you a MTA. This server can receive mails from the internet and send mails to users with the same server or to the internet.
* indimail - For a complete mail server. You can create many virtual domains, access the mails using IMAP or POP3 and all everything that the **indimail-mta** image does.
* indimail-web - Like the **indimail** image with the addition of a web based email based on [Roundcube Mail](https://roundcube.net/).

You also have to decide which distro you want to use. To pull an image, you need a tag. The below gives you the choice of tag to use.

tag|OS Distribution
----|----------------------
xenial|Ubuntu 16.04
bionic|Ubuntu 18.04
focal|Ubuntu 20.04
centos7|CentOS 7
centos8|CentOS 8
debian8|Debian 8
debian9|Debian 9
debian10|Debian10
fc31|Fedora Core 31
fc32|Fedora Core 32
Tumbleweed|openSUSE Tumbleweed
Leap15.2|openSUSE Leap 15.2

Let's say you want to use the **indimail** image and CentOS8

```
$ podman pull cprogrammer/indimail:centos8
Trying to pull docker.io/cprogrammer/indimail:centos8...
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
docker.io/cprogrammer/indimail   centos8      e543dee69ab7   38 hours ago   1.03 GB
```

The big advantage of using docker / podman container is the ease with which you can maintain your server config. You can easily make snapshots of the configuration, push the image to your own docker / podman repository, pull it whenever required and deploy with exactly the same configuration. You don't have to run custom scripts to set your server right. Now we need to decide few things. indimail / indimail-mta requires a filesystem for the queue and a filesystem to store the user's emails. We call it the `queue` directory and the `maildir` directory. i.e.

1. The mail queue denoted by `queue`
2. The user's mail directories denoted by `maildir`

These two directories change often and change continuously. You don't want the snapshots to take too long to complete. Hence it is best to have these two directories on your host rather than be a part of the container image. You can have it part of the container. But when you run the `podman commit` command, the changes to the container since you started it, will be huge. Hence the commit might take very long. It is best that you backup the queue and the maildir directories on the host itself. To achieve this you can do the following

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

Now we can start the container with the `podman run` command. You can use the following script to start any container

```
$ podman run -d -h indimail.org \
    -v /home/podmain/queue:/var/indimail/queue \
    -v /home/podman/mail:/home/mail \
    --name indimail e543dee69ab7
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304
```

Now that we have started a container, we an get the process id of the container

```
$ podman ps
CONTAINER ID  IMAGE                                   COMMAND   CREATED             STATUS                 PORTS  NAMES
0deab2154ef8  docker.io/cprogrammer/indimail:centos8  indimail  About a minute ago  Up About a minute ago         indimail
```

To attach to the container one can do `podman exec -ti 0deab2154ef8 bash` or `podman exec -ti indimail bash`.  The `-ti` stands for interactive and to tell podman to assign a pseudo terminal for the session.  In the below example, we attach to the running container and do ps -ef.  After that we create a virtual domain and then send an email to postmaster@example.com

```
$ podman exec -ti indimail bash
indimail.org:(root) / > ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 07:50 ?        00:00:00 /usr/sbin/svscan /service
root           2       1  0 07:50 ?        00:00:00 supervise log
root           3       1  0 07:50 ?        00:00:00 supervise qmail-smtpd.587
root           4       1  0 07:50 ?        00:00:00 supervise log
root           5       1  0 07:50 ?        00:00:00 supervise qmail-pop3d.110
root           6       1  0 07:50 ?        00:00:00 supervise log
root           7       1  0 07:50 ?        00:00:00 supervise qmail-qmqpd.628
root           8       1  0 07:50 ?        00:00:00 supervise log
root           9       1  0 07:50 ?        00:00:00 supervise qmail-imapd.143
root          10       1  0 07:50 ?        00:00:00 supervise log
root          11       1  0 07:50 ?        00:00:00 supervise qmail-qmtpd.209
root          12       1  0 07:50 ?        00:00:00 supervise log
root          13       1  0 07:50 ?        00:00:00 supervise fetchmail
...
indimail      59       5  0 07:50 ?        00:00:00 /usr/bin/tcpserver -v -c /service/qmail-pop3d.110/variables/MAXDAEMONS -C 25
qmaill        60       8  0 07:50 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/qmqpd.628
qmaill        61      10  0 07:50 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/imapd.143
qmaill        62       6  0 07:50 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/pop3d.110
indimail      63       3  0 07:50 ?        00:00:00 /usr/bin/tcpserver -v -H -R -l 0 -x /etc/indimail/tcp/tcp.smtp.cdb -c /servi
qmaill        64       4  0 07:50 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/smtpd.587
qmaill        65       2  0 07:50 ?        00:00:00 /usr/sbin/multilog t /var/log/svc/svscan
qmails       187      74  0 07:50 ?        00:00:00 qmail-send
qmails       188      74  0 07:50 ?        00:00:00 qmail-send
qmailq       213     187  0 07:50 ?        00:00:00 qmail-clean
root         214     190  0 07:50 ?        00:00:00 qmail-lspawn ./Maildir/
qmailr       215     190  0 07:50 ?        00:00:00 qmail-rspawn
qmailq       216     190  0 07:50 ?        00:00:00 qmail-clean
qmails       217     190  0 07:50 ?        00:00:00 qmail-todo
qmailq       218     190  0 07:50 ?        00:00:00 qmail-clean
indimail     311      55  0 07:50 ?        00:00:00 /usr/sbin/inlookup -i 5 -c 5184000
root         348      96  0 07:50 ?        00:00:00 /usr/bin/coreutils --coreutils-prog-shebang=sleep /usr/bin/sleep 300
root         349       0  0 07:54 pts/0    00:00:00 bash
root         368     349  0 07:54 pts/0    00:00:00 ps -ef
...
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
```

The original container is now longer needed to run. We can stop it and remove the image from memory

```
$ podman stop indimail
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304

$ podman rm indimail
0deab2154ef89688fc1953dc32dcf0c3a4fcde50ce79ed6a47e4886415093304
```

You can now use the container with id `7bcf4b2ff83e` to run the indimail server with mydomain.com as the domain.

I use the below script to run my indimail containers. It should be invoked like this `$ runpod 7bcf4b2ff83e mydomain indimail -d`. The third argument `indimail` is needed. It is actually an entry point in all the indimail, indimail-mta containers to start `svscan` command. The `svscan` command further runs `supervise` command on all services in the `/service` directory. Similarly the `indimail-web` container images have the entry point `webmail` which does everything that `indimail` entrypoint does and addiotionally runs the `apache` web server.

If you use this script it will

1. mount /home/podman/mail as the maildir, /home/podman/queue as the queue
2. Map high number ports on the host to low number ports on the container. If you want to map low number ports or to map the same ports (like port 25 on the host to be mapped to port 25 on the container), you will have to run podman with root privileges. You can map high number ports and set **iptable**(8) rules to map the same ports on the host system to a port on the container. If you run podman with root privileges, you can use --net host to map the container's network to the HOST. In that case you don't have to map the ports using the `-p` argument.
3. Use the [docker entrypoint](https://docs.docker.com/engine/reference/builder/#entrypoint) **indimail** to start all indimail services.
4. Run the container with special privileges that allows it to start like a normal OS with systemd, privileges to do strace and IPC locking

```
#!/bin/sh
if [ $# -lt 1 ] ; then
    echo runpodman imageid name systemd
    exit 1
fi
imageid=$1
if [ $# -gt 3 ] ; then
    name=$2
    systemd=$3
    shift 3
    args=$*
    echo args=$args
elif [ $# -gt 2 ] ; then
    name=$2
    systemd=$3
    args="-ti"
elif [ $# -gt 1 ] ; then
    name=$2
    args="-d"
    systemd="" # choose systemd path automatically
else
    name="indimail"
    systemd=""
fi
tag=`podman images | grep  $imageid | awk '{print $2}'`
if [ -z "$systemd" ] ; then
    case $tag in
        xenial*|debian*|focal*|bionic*)
        systemd=/lib/systemd/systemd
        ;;
        *)
        systemd=/usr/lib/systemd/systemd
        ;;
    esac
fi
echo "podman run $args -h indimail.org --name $name $imageid $systemd"
podman run $args -h indimail.org \
    -p 2025:25 \
    -p 2106:106 \
    -p 2110:110 \
    -p 2143:143 \
    -p 2209:209 \
    -p 2366:366 \
    -p 2465:465 \
    -p 2587:587 \
    -p 2628:628 \
    -p 2993:993 \
    -p 2995:995 \
    -p 4110:4110 \
    -p 4143:4143 \
    -p 9110:9110 \
    -p 9143:9143 \
    -p 8080:80 \
    --cap-add SYS_PTRACE \
    --cap-add SYS_ADMIN \
    --cap-add IPC_LOCK \
    --cap-add SYS_RESOURCE \
    --device /dev/fuse \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v /home/podman/queue:/var/indimail/queue \
    -v /home/podman/mail:/home/mail \
    -v /usr/local/src:/usr/local/src \
    --name $name $imageid $systemd
podman ps
```

## github respository for Dockerfile

The Dockerfile for each of the images is located in a separate subdirectory for each linux distro

* [indimail-mta](https://github.com/mbhangui/docker/tree/master/indimail-mta)
* [indimail](https://github.com/mbhangui/docker/tree/master/indimail)
* [indimail+roundcube](https://github.com/mbhangui/docker/tree/master/webmail)


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
