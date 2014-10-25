#!/usr/bin/env sh

if [ "$1" != "" ]; then 
	export VER="$1"
else
	export VER=v14.06
fi

mkdir allseen_14.06
cd allseen_14.06/

export AJ_ROOT=`pwd`/alljoyn

git clone https://git.allseenalliance.org/gerrit/core/alljoyn.git $AJ_ROOT/core/alljoyn
git clone https://git.allseenalliance.org/gerrit/core/ajtcl.git $AJ_ROOT/core/ajtcl
git clone https://git.allseenalliance.org/gerrit/services/base.git $AJ_ROOT/services/base
git clone https://git.allseenalliance.org/gerrit/services/base_tcl.git $AJ_ROOT/services/base_tcl
git clone https://git.allseenalliance.org/gerrit/data/datadriven_api.git $AJ_ROOT/data/datadriven_api
git clone https://git.allseenalliance.org/gerrit/devtools/codegen.git $AJ_ROOT/devtools/codegen

pushd $AJ_ROOT/core/alljoyn; git checkout -b $VER $VER; popd
pushd $AJ_ROOT/core/ajtcl; git checkout -b $VER $VER; popd
pushd $AJ_ROOT/services/base; git checkout -b $VER $VER; popd
pushd $AJ_ROOT/services/base_tcl; git checkout -b $VER $VER; popd

git clone https://git.allseenalliance.org/gerrit/core/alljoyn-js.git $AJ_ROOT/core/alljoyn-js

curl http://duktape.org/duktape-0.11.0.tar.xz > duktape-0.11.0.tar.xz

if [ "$TERM" = "cygwin" ]; then
	# We are in gitshell on windows so we have to get the xz libs
	mkdir xz-5.0.5
	cd xz-5.0.5
	curl http://tukaani.org/xz/xz-5.0.5-windows.zip > xz-5.0.5-windows.zip
	unzip xz-5.0.5-windows.zip
	export PATH=${PATH}:`pwd`/bin_x86-64
	cd ..
fi

tar -xvf duktape-0.11.0.tar.xz 

export DUKTAPE_DIST=`pwd`/duktape-0.11.0

# Patch before building
pushd alljoyn/core/alljoyn-js/
patch -p1 < ../../../../alljoyn-js.patch
popd

pushd alljoyn/core/alljoyn/
patch -p1 < ../../../../alljoyn-core.patch
popd
