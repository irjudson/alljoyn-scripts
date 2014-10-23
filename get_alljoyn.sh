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
tar -xvf duktape-0.11.0.tar.xz 

export DUKTAPE_DIST=`pwd`/duktape-0.11.0

# Patch before building
pushd alljoyn/core/alljoyn-js/
patch < ../../../../alljoyn-js.patch
popd

pushd alljoyn/core/alljoyn
patch < ../../../../alljoyn-core.patch
popd