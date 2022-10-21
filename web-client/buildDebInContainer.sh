#!/bin/bash

set -exu

pushd jellyfin-web

# workaround for manually installed NodeJS
sed -i -e '/npm | nodejs/d' -e 's/debhelper (>= 9),/debhelper (>= 9)/' debian/control

# build deb
dpkg-buildpackage -us -uc --pre-clean --post-clean

popd

# move
mkdir out
mv jellyfin-web*.{deb,dsc,tar.gz,buildinfo,changes} out
