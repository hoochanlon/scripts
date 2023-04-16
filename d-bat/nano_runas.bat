  
@REM 字母缺失的 是没有调成 CRLF 缘故。
@REM 换行 echo\
@REM 参考来源：https://www.52pojie.cn/thread-1768615-1-1.html

@REM  特权提升，懒得右键或以管理员启动
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"


@echo off

:Loop 
cls
echo\
echo 请根据需求选择:
echo [1] 将程序默认一直以管理员权限运行
echo [2] 去除程序以管理员运行权限
echo [3] 开启默认所有程序都以管理员权限运行
echo [4] 关闭所有程序默认都以管理员权限
echo [5] 正常退出
echo\
choice /c 12345

if %errorlevel% equ 1 (

    set /p soft_path=请将程序路径复制到终端: 
    reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v %soft_path%  /t REG_SZ /d "RUNASADMIN" /f
    echo OK，以管理员权限运行程序已完成。
    timeout /t 5
    GOTO LOOP

) else if %errorlevel% equ 2 (

    set /p soft_path=请将程序路径复制到终端: 
    reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v %soft_path%  /f
    timeout /t 5
    GOTO LOOP

)else if %errorlevel% equ 3 (

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA  /t REG_DWORD /d 0x00000001 /f
    echo OK，已开启默认所有程序都以管理员权限运行。
    timeout /t 5
    GOTO LOOP

)else if %errorlevel% equ 4 (

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA  /t REG_DWORD /d 0x00000000 /f
    echo OK，已关闭所有程序默认都以管理员权限。
    timeout /t 5
    GOTO LOOP
) 

if %errorlevel% equ 5 (GOTO END) 

:END

echo 已正常退出