# Build Scripts

These are the main scripts for building docker/podman images for indimail, indimail-mta, indimail-web. They build and push the images to [hub.docker.com](https://hub.docker.com/u/cprogrammer)

The recommended steps are
1. run buildall-bin-from-src when indimail, indimail-mta sources are updated or when a new distribution is added
2. run buildall-src-image occasionaly. This will build intermediate images having development and other packages needed to build the indimail, indimail-mta packages. This is done only for alpine archlinux gentoo ubi8 centos-stream8 centos-stream9. Once you have the intermediate package you can run buildall-bin-from-src as and when indimail, indimail-mta sources are updated.
3. Instead of <b>2.</b> above, You can run buildall-bin-direct which builds deployable images in a single step. But this will build the base image for alpine, archlinux, gentoo and ubi8 everytime you need to build indimail, indimail-mta

Name|Purpuse
----|-------
buildall-bin-from-obs.yml|Build deployable indimail/indimail-mta docker/podman images by installing rpm/deb from open build service. This excludes alpine archlinux gentoo ubi8 centos8-stream centos9-stream
buildall-web-from-obs.yml|Build deployable webmail docker images. This excludes alpine archlinux gentoo ubi8 centos8-stream centos9-stream
build-single-src.yml|Requires Dockerfile ending with .src extension in indimail-src directory. Builds intermediate images for a single distribution from github sources. This can be used by build-single-bin-from-src to reduce build times. This will have all base packages built and installed. This should be used once in a while to keep upto date with the base OS.
build-single-bin.yml|Requires Dockerfile ending with .bin extension in indimail-src directory. Builds deployable images for a single distribution. This requires source docker image to be pre-built.
buildall-src-image.yml|Build intermediate images for alpine, archlinux, gentoo, ubi8, centos8-stream, centos9-stream from github sources. This can be used by buildall-bin-from-src to reduce build times. This has high build times as packages (all for gentoo) are downloaded and built from source. This has all base packages built and installed. This should be used once in a while to keep upto date with the base OS.
buildall-bin-from-src.yml|Build deployable indimail/indimail-mta images for alpine, archlinux, gentoo, ubi8, centos8-stream, centos9-stream using images from buildall-src-image.yml. This builds only the indimail, indimail-mta packages. The base packages were already built by buildall-src-image.yml. This should be used as and when indimail-mta, indimail-mta sources are modified.
buildall-bin-direct.yml|Build deployable indimail/indimail-mta docker/podman images for alpine, archlinux, gentoo, ubi8, centos8-stream, centos9-stream from github sources, without using the intermediate src image. This has very high build times as many packages (all for gentoo) are downloaded and built from source. This builds all base packages and indimail, indimail-mta packages from source. This shouldn't be used often. The time to complete this script will be more than using `buildall-src-image` and `buildall-bin-from-src` scripts.
