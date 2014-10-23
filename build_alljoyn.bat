@rem off
set VER=v14.06
set CONFIGURATION=release

set PLATFORM="%1"
set ARCH="%2"

if %1.==. GOTO No1
if %2.==. GOTO No2

cd allseen_14.06/
set AJ_ROOT=`pwd`/alljoyn
set DUKTAPE_DIST=`pwd`/duktape-0.11.0

# Build stuff
cd alljoyn/core/alljoyn
scons OS=$PLATFORM CPU=$ARCH BD=on WS=off VARIANT=release BINDINGS=cpp SERVICES="about,config,controlpanel,notification" SDKROOT=`pwd`

set ALLJOYN_DISTDIR=`pwd`/build/$PLATFORM/$ARCH/release/dist/

cd ../ajtcl/
scons WS=off VARIANT=release

cd ../alljoyn-js/
scons WS=off VARIANT=release

cd console/
scons WS=off VARIANT=release

GOTO End

:No1
	echo "You must supply a platform: darwin, linux, or windows"
GOTO End
:No2
	echo "You must supply an architecture: x86 or x86_64"
GOTO End

:End