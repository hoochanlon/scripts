
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"
@echo off
@REM https://www.technipages.com/how-to-fix-windows-printer-error-0x0000011b/

@reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print"  /v "RpcAuthnLevelPrivacyEnabled" /t REG_DWORD /d 0 /f

@wusa /uninstall /kb:5005565 /quiet
@wusa /uninstall /kb:5005566 /quiet
@wusa /uninstall /kb:5005568 /quiet
@wusa /uninstall /kb:5022497 /quiet
@wusa /uninstall /kb:5012170 /quiet
@wusa /uninstall /kb:5023706 /quiet
@wusa /uninstall /kb:5007186 /quiet

@net stop spooler
@del /f /s /q C:\Windows\System32\spool\PRINTERS\*
@net start spooler
@pause
