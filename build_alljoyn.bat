@echo on

set MSVC_VERSION=12.0
set CONFIGURATION=release

if %1.==. GOTO No1
if %2.==. GOTO No2

cd alljoyn
set CURDIR=%CD%
set AJ_ROOT=%CURDIR%
set DUKTAPE_DIST=%CURDIR%\duktape-1.0.2

REM Build stuff
cd core\alljoyn
set SDKROOT=%CD%
call scons MSVC_VERSION=%MSVC_VERSION% OS=%1 CPU=%2 BR=on WS=off VARIANT=release BINDINGS=c++ SERVICES="about,config,controlpanel,notification" SDKROOT=%SDKROOT%
set CURDIR=%CD%
set ALLJOYN_DISTDIR=%CURDIR%\build\%1\%2\release\dist

cd ..\ajtcl
call scons MSVC_VERSION=%MSVC_VERSION% OS=%1 CPU=%2 WS=off VARIANT=release

cd ..\alljoyn-js
call scons MSVC_VERSION=%MSVC_VERSION% OS=%1 CPU=%2 WS=off VARIANT=release

cd console
call scons MSVC_VERSION=%MSVC_VERSION% OS=%1 CPU=%2 WS=off VARIANT=release

GOTO End

:No1
	echo "You must supply a platform: darwin, linux, or win7"
GOTO End
:No2
	echo "You must supply an architecture: x86 or x86_64"
GOTO End

:End
