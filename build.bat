@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set BUILD_DIR=build
set ARCH=x64
set CONFIG=Release
set VS_VERSION=2019
set CMAKE_EXTRA_ARGS=

set VS_PATH=
if exist "C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Professional\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Professional
if exist "C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Community
if exist "C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Enterprise\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\%VS_VERSION%\Enterprise
if exist "C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Professional\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Professional
if exist "C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Community
if exist "C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Enterprise\VC\Auxiliary\Build\vcvars64.bat" set VS_PATH=C:\Program Files\Microsoft Visual Studio\%VS_VERSION%\Enterprise

if not defined VS_PATH (
    echo [ERROR] Visual Studio %VS_VERSION% not found.
    echo Please install Visual Studio %VS_VERSION% with C++ workload.
    goto :error
)

set VCVARS=!VS_PATH!\VC\Auxiliary\Build\vcvars64.bat
set MSBUILD_PATH=!VS_PATH!\MSBuild\Current\Bin\amd64
if not exist "!MSBUILD_PATH!\MSBuild.exe" set MSBUILD_PATH=!VS_PATH!\MSBuild\Current\Bin

:parse_args
if "%~1"=="" goto after_parse
if /i "%~1"=="debug" (
    set CONFIG=Debug
    shift
    goto parse_args
)
if /i "%~1"=="release" (
    set CONFIG=Release
    shift
    goto parse_args
)
if /i "%~1"=="clean" (
    set DO_CLEAN=1
    shift
    goto parse_args
)
if /i "%~1"=="gen" (
    set DO_GEN_ONLY=1
    shift
    goto parse_args
)
if /i "%~1"=="all" (
    set CMAKE_EXTRA_ARGS=!CMAKE_EXTRA_ARGS! -DENABLE_LIBFDK=ON -DENABLE_QSV11=ON -DENABLE_WIN_MF=ON -DENABLE_WIN_DSHOW=ON
    shift
    goto parse_args
)
if /i "%~1"=="help" goto show_help
echo Unknown argument: %~1
goto show_help

:after_parse

echo ==================================================
echo  libobs Build Script
echo  VS Version : %VS_VERSION%
echo  Architecture: %ARCH%
echo  Config     : %CONFIG%
echo  Build Dir  : %BUILD_DIR%
echo  VS Path    : !VS_PATH!
echo ==================================================
echo.

call "!VCVARS!"
set "PATH=!MSBUILD_PATH!;%PATH%"

where cmake >nul 2>nul
if errorlevel 1 (
    echo [ERROR] cmake not found in PATH.
    echo Please install CMake and add it to PATH.
    goto :error
)

if defined DO_CLEAN (
    echo [INFO] Cleaning previous build...
    if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
)

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

echo [INFO] Generating Visual Studio %VS_VERSION% %ARCH% project...
cmake -S . -B "%BUILD_DIR%" -G "Visual Studio 16 2019" -A %ARCH% !CMAKE_EXTRA_ARGS!
if errorlevel 1 (
    echo [ERROR] CMake configuration failed.
    goto :error
)

if defined DO_GEN_ONLY (
    echo.
    echo [INFO] Project generation complete.
    echo [INFO] Open "%BUILD_DIR%\libobs.sln" in Visual Studio %VS_VERSION%.
    goto :success
)

echo.
echo [INFO] Building %CONFIG% %ARCH%...
cmake --build "%BUILD_DIR%" --config %CONFIG% --parallel
if errorlevel 1 (
    echo [ERROR] Build failed.
    goto :error
)

echo.
echo [INFO] Build succeeded!
echo [INFO] Output: %BUILD_DIR%\output\%CONFIG%\
echo.

goto :success

:show_help
echo.
echo Usage: build.bat [debug^|release] [clean] [gen] [all] [help]
echo.
echo Options:
echo   debug    Build in Debug configuration (default: Release)
echo   release  Build in Release configuration
echo   clean    Clean previous build before building
echo   gen      Only generate VS project, do not build
echo   all      Enable all optional plugins (libfdk, qsv11, win-mf, win-dshow)
echo   help     Show this help message
echo.
echo Optional plugins (disabled by default):
echo   ENABLE_LIBFDK    - obs-libfdk (FDK AAC encoder)
echo   ENABLE_QSV11     - obs-qsv11 (Intel QuickSync)
echo   ENABLE_WIN_MF    - win-mf (Media Foundation)
echo   ENABLE_WIN_DSHOW - win-dshow (DirectShow)
echo   ENABLE_VLC       - vlc-video (VLC video source)
echo.
echo Examples:
echo   build.bat              Release build
echo   build.bat debug        Debug build
echo   build.bat clean        Clean and Release build
echo   build.bat all          Enable all plugins and Release build
echo   build.bat gen          Only generate VS2019 x64 solution
echo.
goto :eof

:success
endlocal
exit /b 0

:error
endlocal
exit /b 1
