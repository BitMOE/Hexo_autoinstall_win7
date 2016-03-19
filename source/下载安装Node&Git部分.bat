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
echo     ����ӭʹ�� Hexo һ����װ�ű��� Windows ƽ̨����        
echo.
echo         ���ű��� Bitmoe Inc. ��д���ṩ����֧�֣�
echo                 https://www.bitmoe.com
echo.
echo.
echo ������ʼ��װ HEXO �������ĵȴ�...
ping 1 -w 100>nul
echo.
echo �ж�ϵͳ���� 32bit/64bit...
if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="X86" (set systype=32) ELSE set systype=64
echo ��ϵͳΪ%systype%λ
echo.
if "%installmode%"=="OFFLINE" goto INSTALL
echo ������ʼ���ذ�װ�����ù���ȡ�����������...
echo.
echo �ڰ�װ�Ĺ����У�����ݼ��������Ľ̵̳�����ע��Github���½��ֿ⣬�����Ķ��̵̳�ͬʱ���ű������������...
echo ע�⣺������ع��̱Ƚϻ����������������߰���װ!
echo.
echo �Ķ���Ϻ��밴�س���ʼ!
pause>nul
echo.
echo ��ʼ���� Node...
echo.
if "%systype%"=="32" (wget %nodejs32%) ELSE (wget %nodejs64%) 
echo.
echo ��ʼ���� Git...
echo.
if "%systype%"=="32" (wget %git32%) ELSE (wget %git64%)
echo.
:INSTALL
echo ��ʼ���ؽ�ѹ���...
wget %otherconfig%7z.exe
wget %otherconfig%7z.dll
echo.
echo ��ʼ��������..
wget %otherconfig%config.sh
echo.
echo ��ʼ��װ Node...
if "%systype%"=="32" (start /wait node-v4.4.0-x32.msi /passive)ELSE (start /wait node-v4.4.0-x64.msi /passive) 
echo ��ʼ��װ Git...
mkdir PortableGit
if "%systype%"=="32" (7z x PortableGit-2.7.4-32-bit.7z.exe -o"PortableGit")ELSE (7z x PortableGit-2.7.4-64-bit.7z.exe -o"PortableGit") 
del PortableGit\post-install.bat
assoc .sh=auto_sh
ftype auto_sh="%cd%\PortableGit\git-bash.exe" --no-cd "%%L" %%*
echo.
echo ��װ��ɣ��ȴ������ Github �˵Ĳ��裬���������ɣ����������������...
pause>nul
del wget.exe
del PortableGit-2.7.4-64-bit.7z.exe
del PortableGit-2.7.4-32-bit.7z.exe
del node-v4.4.0-x86.msi
del node-v4.4.0-x64.msi
del 7z.exe
del 7z.dll
copy config.sh ˫����ʼ�������ýű�.sh
del config.sh
del install.ini
del hexo.data
del �����������Թ���Ա�������.bat
