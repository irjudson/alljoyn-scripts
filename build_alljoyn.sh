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

cd allseen_14.06/
export AJ_ROOT=`pwd`/alljoyn
export DUKTAPE_DIST=`pwd`/duktape-0.11.0

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