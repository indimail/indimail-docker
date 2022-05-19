# Build Scripts

These are the main scripts for building docker/podman images for indimail, indimail-mta, indimail-web. They build and push the images to [hub.docker.com](https://hub.docker.com/u/cprogrammer)

The recommended steps are

1. run buildall-bin when indimail, indimail-mta sources are updated or when a new distribution is added
2. run build-indimail-src occasionaly. This will build intermediate images having development and other packages needed to build the indimail, indimail-mta packages. This is done only for alpine archlinux gentoo ubi8. Once you have the intermediate package you can run buildall-src as and when indimail, indimail-mta sources are updated.
3. Instead of <b>2.</b> above, You can run buildall-src which builds deployable images in a single step. But this will build the base image for alpine, archlinux, gentoo and ubi8 everytime you need to build indimail, indimail-mta

Name|Purpuse
----|-------
buildall-bin.yml|Build deployable indimail/indimail-mta docker/podman images by installing rpm/deb from open build service. This excludes alpine archlinux gentoo ubi8
buildall-web.yml|Build deployable webmail docker images. This excludes alpine archlinux gentoo ubi8
build-indimail-src.yml|Build intermediate images for alpine, archlinux, gentoo, ubi8 from github sources. This can be used by build-bin-from-src to reduce build times. This has high build times as packages (all for gentoo) are downloaded and built from source. This has all base packages built and installed. This should be used once in a while to keep upto date with the base OS.
build-bin-from-src.yml|Build deployable indimail/indimail-mta images for alpine, archlinux, gentoo, ubi8 using images from build-indimail-src.yml. This builds only the indimail, indimail-mta packages. The base packages were already built by build-indimail-src.yml. This should be used as and when indimail-mta, indimail-mta sources are modified.
buildall-src.yml|Build deployable indimail/indimail-mta docker/podman images for alpine archlinux gentoo ubi8 from github sources. This has very high build times as many packages (all for gentoo) are downloaded and built from source. This builds all base packages and indimail, indimail-mta packages from source. This shouldn't be used often. The time to complete this script will be more than using `build-indimail-src` and `build-bin-from-src` scripts.
