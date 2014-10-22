#!/usr/bin/env bash
export VER=v14.06
export CONFIGURATION=release

export PLATFORM="$1"
export ARCH="$2"

if [ "$PLATFORM" = "" ]; then
	echo "You must supply a platform: darwin, linux, or windows"
	exit 1
fi

if [ "$ARCH" = "" ]; then
	echo "You must supply an architecture: x86 or x86_64"
	exit 1
fi

if [ "$PLATFORM" = "linux" ]; then
	echo "Please make sure you have the following packages installed (for ubuntu 12+):"
	echo "sudo apt-get install git build-essential curl scons libssl-dev libc6-dev-i386 g++-multilib"
fi

mkdir allseen_14.06
cd allseen_14.06/

export AJ_ROOT=`pwd`/alljoyn

git clone https://git.allseenalliance.org/gerrit/core/alljoyn.git $AJ_ROOT/core/alljoyn
git clone https://git.allseenalliance.org/gerrit/core/ajtcl.git $AJ_ROOT/core/ajtcl
git clone https://git.allseenalliance.org/gerrit/services/base.git $AJ_ROOT/services/base
git clone https://git.allseenalliance.org/gerrit/services/base_tcl.git $AJ_ROOT/services/base_tcl

pushd $AJ_ROOT/core/alljoyn; git checkout -b $VER $VER; popd
pushd $AJ_ROOT/services/base; git checkout -b $VER $VER; popd
pushd $AJ_ROOT/services/base_tcl; git checkout -b $VER $VER; popd

git clone https://git.allseenalliance.org/gerrit/core/alljoyn-js.git $AJ_ROOT/core/alljoyn-js

curl http://duktape.org/duktape-0.11.0.tar.xz > duktape-0.11.0.tar.xz
tar -xvf duktape-0.11.0.tar.xz 

export DUKTAPE_DIST=`pwd`/duktape-0.11.0

# Patch before building
pushd alljoyn/core/alljoyn-js/
curl https://gist.githubusercontent.com/irjudson/4912b58c2a00c0a07dd7/raw/3efe913d00b3ba90b63f354dea68be98cf8de4c0/gistfile1.txt > /tmp/alljoyn-js.patch
patch < /tmp/alljoyn-js.patch
popd

# Build stuff
cd alljoyn/core/alljoyn
scons OS=$PLATFORM CPU=$ARCH BD=on WS=off VARIANT=release BINDINGS=cpp SERVICES="about,config,controlpanel,notification" SDKROOT=`pwd`

export ALLJOYN_DISTDIR=`pwd`/build/$PLATFORM/$ARCH/release/dist/

cd ../ajtcl/
scons WS=off VARIANT=release

cd ../alljoyn-js/
scons WS=off VARIANT=release

cd console/
scons WS=off VARIANT=release