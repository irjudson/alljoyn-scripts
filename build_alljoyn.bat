@rem off
set VER=v14.06
set CONFIGURATION=release

if %1.==. GOTO No1
if %2.==. GOTO No2

cd allseen_14.06/
set AJ_ROOT=`pwd`/alljoyn
set DUKTAPE_DIST=`pwd`/duktape-0.11.0

# Build stuff
cd alljoyn/core/alljoyn
scons MSVC_VERSION=12.0 OS=%1 CPU=%2 BD=on WS=off VARIANT=release BINDINGS=cpp SERVICES="about,config,controlpanel,notification" SDKROOT=`pwd`

set ALLJOYN_DISTDIR=`pwd`/build/%1/%2/release/dist/

cd ../ajtcl/
scons MSVC_VERSION=12.0 WS=off VARIANT=release

cd ../alljoyn-js/
scons MSVC_VERSION=12.0 WS=off VARIANT=release

cd console/
scons MSVC_VERSION=12.0 WS=off VARIANT=release

GOTO End

:No1
	echo "You must supply a platform: darwin, linux, or windows"
GOTO End
:No2
	echo "You must supply an architecture: x86 or x86_64"
GOTO End

:End