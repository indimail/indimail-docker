Dockerfile repository for automated builds.
==========================================

This repo contains repository for Dockerfiles used for building
docker/podman images at

https://hub.docker.com/r/cprogrammer/autobuild-indimail

The following tags/images can be pulled by executing
the commands

a) docker
   docker pull cprogrammer/autobuild-indimail:tag

or

b) podman
   podman pull cprogrammer/autobuild-indimail:tag

Replace tag in the above command with one of the following

disco    for ubuntu 19.04
bionic   for ubuntu 18.04
xenial   for ubuntu 16.04
centos7  for centos7
debian10 for debian10
debian9  for debian9
debian8  for debian8
fc31     for fc31
fc30     for fc30
