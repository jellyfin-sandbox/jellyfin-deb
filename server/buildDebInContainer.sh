#!/bin/bash

set -exu

pushd jellyfin-code

# workaround for manually installed dotnet
sed -i -e '/dotnet-sdk-6.0,/d' debian/control

# build deb
export CONFIG_SITE="/etc/dpkg-cross/cross-config.${1:-amd64}"
dpkg-buildpackage -us -uc --pre-clean --post-clean

popd

# move
mkdir out
mv jellyfin-web*.{deb,dsc,tar.gz,buildinfo,changes} out
