#!/usr/bin/env bash

export PLATFORM="$1"
export ARCH="$2"
export CONFIGURATION="$3"

if [ "$PLATFORM" = "" ]; then
	echo "You must supply a platform: darwin, linux, or windows"
	exit 1
fi

if [ "$ARCH" = "" ]; then
	echo "You must supply an architecture: x86 (All) or x86_64 (Only linux & Windows)"
	exit 1
fi

if [ "$CONFIGURATION" = "" ]; then
	CONFIGURATION="debug"
fi

# if [ "$PLATFORM" = "darwin" ]; then
# 	export ARCH="x86"
# fi

if [ "$PLATFORM" = "linux" ]; then
	echo "Please make sure you have the following packages installed (for ubuntu 12+):"
	echo "sudo apt-get install git build-essential curl scons libssl-dev libc6-dev-i386 g++-multilib"
fi

cd alljoyn
export AJ_ROOT=`pwd`
export DUKTAPE_DIST=`pwd`/duktape-1.0.2

# Build stuff
cd core/alljoyn

if [ "$PLATFORM" != "windows" ]; then
	scons OS=$PLATFORM CPU=$ARCH BD=on WS=off VARIANT=release BINDINGS=cpp SERVICES="about,config,controlpanel,notification" SDKROOT=`pwd`
	export ALLJOYN_DISTDIR=`pwd`/build/$PLATFORM/$ARCH/release/dist/
fi

cd ../ajtcl/
scons WS=off VARIANT=release

cd ../alljoyn-js/
scons WS=off VARIANT=release

cd console/
scons WS=off VARIANT=release