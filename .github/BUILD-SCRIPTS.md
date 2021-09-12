# Build Scripts

These are the main scripts for building docker/podman images for indimail, indimail-mta, indimail-web. They build and push the images to [hub.docker.com](https://hub.docker.com/u/cprogrammer)

Name|Purpuse
----|-------
buildall-bin.yml|Build deployable indimail/indimail-mta docker/podman images by installing rpm/deb from open build service
buildall-web.yml|Build deployable webmail docker images
buildall-src.yml|Build deployable indimail/indimail-mta docker/podman images for alpine archlinux gentoo ubi8 from github sources. This has very high build times as many packages (all for gentoo) are downloaded and built from source. This builds all base packages and indimail, indimail-mta packages from source.
build-bin-from-src.yml|Build deployable indimail/indimail-mta images for alpine, archlinux, gentoo, ubi8 using images from build-indimail-src.yml. This builds only the indimail, indimail-mta packages. The base packages were already built by build-indimail-src.yml
build-indimail-src.yml|Build intermediate images for alpine, archlinux, gento, ubi8 from github sources. This can be used by build-bin-from-src to reduce build times. This has high build times as packages (all for gentoo) are downloaded and built from source. This has all base packages built and installed.
