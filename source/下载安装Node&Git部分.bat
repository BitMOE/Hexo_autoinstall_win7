cd /d %~dp0
@echo off
for /f "tokens=1-6 delims==" %%i in (install.ini) do (
	if "%%i"=="MODE" set installmode=%%j
	if "%%i"=="HOST_NODE_64" set nodejs64=%%j
	if "%%i"=="HOST_NODE_32" set nodejs32=%%j
	if "%%i"=="HOST_GIT_64" set git64=%%j
	if "%%i"=="HOST_GIT_32" set git32=%%j
	if "%%i"=="OTHER" set otherconfig=%%j
 )
cls
copy hexo.data wget.exe
cls
echo.
echo ===========================================================
echo   ______   _____  _________  ____    ____   ___   ________  
echo  ^|_   _ \ ^|_   _^|^|  _   _  ^|^|_   \  /   _^|.'   `.^|_   __  ^| 
echo    ^| ^|_) ^|  ^| ^|  ^|_/ ^| ^| \_^|  ^|   \/   ^| /  .-.  \ ^| ^|_ \_^| 
echo    ^|  __'.  ^| ^|      ^| ^|      ^| ^|\  /^| ^| ^| ^|   ^| ^| ^|  _^| _  
echo   _^| ^|__) ^|_^| ^|_    _^| ^|_    _^| ^|_\/_^| ^|_\  `-'  /_^| ^|__/ ^| 
echo  ^|_______/^|_____^|  ^|_____^|  ^|_____^|^|_____^|`.___.'^|________^| 
echo ===========================================================
echo.
echo     》欢迎使用 Hexo 一键安装脚本（ Windows 平台）《        
echo.
echo         本脚本由 Bitmoe Inc. 编写并提供技术支持！
echo                 https://www.bitmoe.com
echo.
echo.
echo 即将开始安装 HEXO ，请耐心等待...
ping 1 -w 100>nul
echo.
echo 判断系统类型 32bit/64bit...
if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="X86" (set systype=32) ELSE set systype=64
echo 该系统为%systype%位
echo.
if "%installmode%"=="OFFLINE" goto INSTALL
echo 即将开始下载安装包，该过程取决于你的网速...
echo.
echo 在安装的过程中，请根据即将弹出的教程的内容注册Github并新建仓库，在你阅读教程的同时，脚本将会持续下载...
echo 注意：如果下载过程比较缓慢，建议下载离线包安装!
echo.
echo 阅读完毕后请按回车开始!
pause>nul
echo.
echo 开始下载 Node...
echo.
if "%systype%"=="32" (wget %nodejs32%) ELSE (wget %nodejs64%) 
echo.
echo 开始下载 Git...
echo.
if "%systype%"=="32" (wget %git32%) ELSE (wget %git64%)
echo.
:INSTALL
echo 开始下载解压组件...
wget %otherconfig%7z.exe
wget %otherconfig%7z.dll
echo.
echo 开始下载配置..
wget %otherconfig%config.sh
echo.
echo 开始安装 Node...
if "%systype%"=="32" (start /wait node-v4.4.0-x32.msi /passive)ELSE (start /wait node-v4.4.0-x64.msi /passive) 
echo 开始安装 Git...
mkdir PortableGit
if "%systype%"=="32" (7z x PortableGit-2.7.4-32-bit.7z.exe -o"PortableGit")ELSE (7z x PortableGit-2.7.4-64-bit.7z.exe -o"PortableGit") 
del PortableGit\post-install.bat
assoc .sh=auto_sh
ftype auto_sh="%cd%\PortableGit\git-bash.exe" --no-cd "%%L" %%*
echo.
echo 安装完成！等待您完成 Github 端的步骤，如果您已完成，按任意键继续配置...
pause>nul
del wget.exe
del PortableGit-2.7.4-64-bit.7z.exe
del PortableGit-2.7.4-32-bit.7z.exe
del node-v4.4.0-x86.msi
del node-v4.4.0-x64.msi
del 7z.exe
del 7z.dll
copy config.sh 双击开始运行配置脚本.sh
del config.sh
del install.ini
del hexo.data
del 必须必须必须以管理员身份运行.bat
