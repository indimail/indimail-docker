# Build Scripts

Name|Purpuse
----|-------
buildall-bin.yml|Build deployable indimail/indimail-mta docker/podman images by installing rpm/deb from open build service
buildall-web.yml|Build deployable webmail docker images
buildall-src.yml|Build deployable indimail/indimail-mta docker/podman images for alpine archlinux gentoo ubi8 from github sources
build-bin-from-src.yml|Build deployable indimail/indimail-mta images for alpine, archlinux, gentoo, ubi8 using images from build-indimail-src.yml
build-indimail-src.yml|Build intermediate images for alpine, archlinux, gento, ubi8 from github sources. This can be used by build-bin-from-src to reduce build times
