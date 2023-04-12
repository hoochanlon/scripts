@REM  特权提升，懒得右键或以管理员启动
@REM %1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@REM @cd /d "%~dp0"

@REM 特权提升可行性研究
@REM curl -L  https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/oh_my_wifi.bat|cmd
@REM C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 :: ^& echo curl -L https://ghproxy.com/https://github.com/hoochanlon/ihs-simple/raw/main/d-bat/oh_my_wifi.bat ^| cmd && pause","","runas",1)(window.close)&&exit
@REM 输出空行
@ECHO/
@echo 该获取所有WiFi密码，仅供研究学习使用
@ECHO/
@echo WiFi及密码列表如下：
@ECHO/
@netsh wlan show profiles | for /f "tokens=2 delims=:" %%i in ('findstr "用户配置文件"') do @echo %%i && netsh wlan show profiles name=%%i key=clear | findstr "关键内容"
@ECHO/

@timeout /NOBREAK /T 180