#!/usr/bin/env sh

if [ "$1" != "" ]; then 
	export VER="$1"
else
	export VER=v14.06
fi

if [ "$VER" == "v14.06" ]; then
	mkdir alljoyn-14.06
	ln -s alljoyn-14.06 alljoyn
else
	mkdir alljoyn-latest
	ln -s alljoyn-latest alljoyn
fi
cd alljoyn

DUKTAPE_VERSION=1.0.2

export AJ_ROOT=`pwd`

git clone https://git.allseenalliance.org/gerrit/core/alljoyn.git $AJ_ROOT/core/alljoyn
git clone https://git.allseenalliance.org/gerrit/core/ajtcl.git $AJ_ROOT/core/ajtcl
git clone https://git.allseenalliance.org/gerrit/core/alljoyn-js.git $AJ_ROOT/core/alljoyn-js
git clone https://git.allseenalliance.org/gerrit/services/base.git $AJ_ROOT/services/base
git clone https://git.allseenalliance.org/gerrit/services/base_tcl.git $AJ_ROOT/services/base_tcl
git clone https://git.allseenalliance.org/gerrit/data/datadriven_api.git $AJ_ROOT/data/datadriven_api
git clone https://git.allseenalliance.org/gerrit/devtools/codegen.git $AJ_ROOT/devtools/codegen
git clone https://git.allseenalliance.org/gerrit/gateway/gwagent.git $AJ_ROOT/gateway/gwagent

if [ "$VER" != "latest" ]; then
	pushd $AJ_ROOT/core/alljoyn; git checkout -b $VER $VER; popd
	pushd $AJ_ROOT/core/ajtcl; git checkout -b $VER $VER; popd
	pushd $AJ_ROOT/services/base; git checkout -b $VER $VER; popd
	pushd $AJ_ROOT/services/base_tcl; git checkout -b $VER $VER; popd
fi

curl http://duktape.org/duktape-$DUKTAPE_VERSION.tar.xz > duktape-$DUKTAPE_VERSION.tar.xz

if [ "$TERM" = "cygwin" ]; then
	# We are in gitshell on windows so we have to get the xz libs
	mkdir xz-5.0.5
	cd xz-5.0.5
	curl http://tukaani.org/xz/xz-5.0.5-windows.zip > xz-5.0.5-windows.zip
	unzip xz-5.0.5-windows.zip
	export PATH=${PATH}:`pwd`/bin_x86-64
	cd ..
fi

tar -xvf duktape-$DUKTAPE_VERSION.tar.xz 

export DUKTAPE_DIST=`pwd`/duktape-$DUKTAPE_VERSION

if [ "$OS" = "Windows_NT" ]; then
	# Patch before building
	pushd core/alljoyn-js/
	patch -p1 < ../../../14.06/alljoyn-js.patch
	popd

	pushd core/alljoyn/
	patch -p1 < ../../../14.06/alljoyn-core.patch
	popd

	pushd core/ajtcl
	patch -p1 < ../../../14.06/alljoyn-tcl.patch
	popd
fi
