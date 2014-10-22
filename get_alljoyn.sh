#!/usr/bin/env sh

if [ "$1" != "" ]; then 
	export VER="$1"
else
	export VER=v14.06
fi

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