#!/bin/bash

set -exu

pushd jellyfin-code

# workaround for manually installed dotnet
sed -i -e '/dotnet-sdk-6.0,/d' debian/control

# build deb
export CONFIG_SITE="/etc/dpkg-cross/cross-config.amd64"
dpkg-buildpackage --unsigned-source --unsigned-changes --pre-clean --post-clean --host-arch "${1:-amd64}" --build-profiles=cross

popd

# move
mkdir out
mv jellyfin*.{deb,dsc,tar.gz,buildinfo,changes} out
