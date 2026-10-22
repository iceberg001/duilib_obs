@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat" >nul 2>&1
set "PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\amd64;%PATH%"
MSBuild.exe "J:\直播相关\libobs\build\ui\ObsClient.vcxproj" /p:Configuration=Release /p:Platform=x64 /v:m