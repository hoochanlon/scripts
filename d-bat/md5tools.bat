@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit & cd /d "%~dp0"

@echo off
setlocal
:menu
echo.
echo ***********************************************
echo MD5、SHA1、SHA256 哈希值计算、比较、校验工具
echo.
echo by https://github.com/hoochanlon
echo.
echo 选项
echo [1]. 计算文件 MD5、SHA1、SHA256 哈希值。
echo [2]. 比较文件 MD5、SHA1、SHA256 哈希值。
echo [3]. 校验文件 MD5、SHA1、SHA256 哈希值。
echo [4]. 刷新，并返回菜单。
echo.
echo ***********************************************
echo.
goto :select

:select
set /p choice=请输入选项数字：
set "match=false"

if "%choice%"=="1" (
    set /p filePath=请输入文件路径：
    call :calcHash "%filePath%"
    goto select
) else if "%choice%"=="2" (
    set /p filePath1=请输入第一个文件路径：
    set /p filePath2=请输入第二个文件路径：
    call :compareHash "%filePath1%" "%filePath2%"
    goto select
) else if "%choice%"=="3" (
    set /p hashcode=请输入哈希值：
    set /p filePathS=请输入文件路径：
    call :jiaoyanHash "%hashcode%" "%filePathS%"
    goto select
) else if "%choice%"=="4" (
    cls
    goto menu
) else (
    echo 无效的选项。
    goto menu
)
exit /b


:calcHash
rem 计算文件的 MD5、SHA1、SHA256 哈希值
for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% MD5') do (
    set "md5Hash=%%a"
    goto :calcMD5
)
:calcMD5
echo MD5 哈希值：%md5Hash%

for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% SHA1') do (
    set "sha1Hash=%%a"
    goto :calcSHA1
)
:calcSHA1
echo SHA1 哈希值：%sha1Hash%

for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile %filePath% SHA256') do (
    set "sha256Hash=%%a"
    goto :calcSHA256
)
:calcSHA256
echo SHA256 哈希值：%sha256Hash%
echo.
exit /b

:compareHash
echo.
for /f "skip=1 tokens=* delims=" %%a in ('certutil -hashfile "%filePath1%" MD5') do (
    set "md5Hash1=%%a"
    for /f "skip=1 tokens=* delims=" %%b in ('certutil -hashfile "%filePath2%" MD5') do (
    set "md5Hash2=%%b"
        for /f "skip=1 tokens=* delims=" %%c in ('certutil -hashfile "%filePath1%" SHA1') do (
            set "sha1Hash1=%%c"
                    for /f "skip=1 tokens=* delims=" %%d in ('certutil -hashfile "%filePath2%" SHA1') do (
            set "sha1Hash2=%%d"
            for /f "skip=1 tokens=* delims=" %%e in ('certutil -hashfile "%filePath1%" SHA256') do (
                set "sha256Hash1=%%e"
                for /f "skip=1 tokens=* delims=" %%f in ('certutil -hashfile "%filePath2%" SHA256') do (
                set "sha256Hash2=%%f"
                goto :compareAllHash
                )
            )
            )
    )
    )
    )
    )
)

:compareAllHash
if "%md5Hash1%"=="%md5Hash2%" (
    echo.
    echo 两个文件的MD5哈希值相同
    echo %md5Hash1%
    echo %md5Hash2%
    set "match=true"
) else (
    echo.
    echo 两个文件的MD5哈希值不同
    echo %md5Hash1%
    echo %md5Hash2%
)

if "%sha1Hash1%"=="%sha1Hash2%" (
    echo.
    echo 两个文件的SHA1哈希值相同
    echo %sha1Hash1%
    echo %sha1Hash2%
    set "match=true"
) else (
    echo.
    echo 两个文件的SHA1哈希值不同
    echo %sha1Hash1%
    echo %sha1Hash2%
)


if "%sha256Hash1%"=="%sha256Hash2%" (
    echo.
    echo 两个文件的SHA256哈希值相同
    echo %sha256Hash1%
    echo %sha256Hash2%
    set "match=true"
    echo.
) else (
    echo.
    echo 两个文件的SHA256哈希值不同
    echo %sha256Hash1%
    echo %sha256Hash2%
    echo.
)


:jiaoyanHash
echo.
for /f "skip=1 tokens=* delims=" %%g in ('certutil -hashfile "%filePathS%" MD5') do (
    set "jy_md5Hash=%%g"
        for /f "skip=1 tokens=* delims=" %%h in ('certutil -hashfile "%filePathS%" SHA1') do (
            set "jy_sha1Hash=%%h"
            for /f "skip=1 tokens=* delims=" %%i in ('certutil -hashfile "%filePathS%" SHA256') do (
                set "jy_sha256Hash=%%i"
                goto :jiaoyanAllHash
                )
            )
         )
    )
)

:jiaoyanAllHash
if "%jy_md5Hash%"=="%hashcode%" (
    echo 文件的MD5哈希值相同
    echo %jy_md5Hash%
    echo %hashcode%
    echo.
    set "match=true"
)
if "%jy_sha1Hash%"=="%hashcode%" (
    echo 文件的SHA1哈希值相同
    echo %jy_sha1Hash%
    echo %hashcode%
    echo.
    set "match=true"
)
if "%jy_sha256Hash%"=="%hashcode%" (
    echo 文件的SHA256哈希值相同
    echo %jy_sha256Hash%
    echo %hashcode%
    echo.
    set "match=true"
)

if "%match%"=="false" (
    echo MD5、SHA1、SHA256哈希值全不匹配。
    echo.
)

