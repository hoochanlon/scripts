@REM 网页资源链接来自腾讯下载中心
@echo off
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"

@echo/
echo "正在执行自动化钉钉安装操作，请勿关闭cmd窗口，否则会导致安装失败！ "
@echo/
@echo/
@echo "正在下载钉钉，请稍候... "
powershell -c wget -uri "https://webcdn.m.qq.com/spcmgr/download/7.0.30-Release.5259107.exe" -OutFile "C:/Users/${env:UserName}/Downloads/7.0.30-Release.5259107.exe" && @echo/

@echo "正在安装钉钉，请耐心等待片刻"


@start /wait C:\Users\%username%\Downloads\7.0.30-Release.5259107.exe /S /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /FORCE

@echo "钉钉，已完成安装，可以关闭窗口"
pause
