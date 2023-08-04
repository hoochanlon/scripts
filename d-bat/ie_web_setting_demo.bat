@SETLOCAL ENABLEDELAYEDEXPANSION


@ECHO OFF

@CLS

@ECHO ON


@ECHO 开始进行IE浏览器运行环境设置.......

@ECHO.&&ECHO.

@echo 设置IE8版本以上兼容性视图中显示所有网站

@REM 关于网站对应的hex值，情配合 https://github.com/hoochanlon/scripts/blob/main/d-pwsh/clac_ie_clearablelistdata_hex.ps1 使用，这个例子是B站的hex值。
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /v UserFilter /t REG_BINARY /f /d 411F00005308ADBA01000000FFFFFFFF01000000010000000C00000000000000000000010100000010007700770077002E00620069006C006900620069006C0069002E0063006F006D00

@ECHO 正在添加受信任列表......（）

@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\baidu.com\www" /v http /t REG_DWORD /d 0x00000002 /f
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\10.10.10.1" /v http /t REG_DWORD /d 0x00000002 /f
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.1.1" /v http /t REG_DWORD /d 0x00000002 /f
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.1.2" /v http /t REG_DWORD /d 0x00000002 /f


@ECHO.&&ECHO 正在进行受信站点ActiveX权限设置......

@SET RegPath=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1
@SET RegPath1=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2
@SET RegPath2=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3

@REG ADD "%RegPath%" /V DisplayName /T REG_SZ /D "本地 Intranet" /F

@REG ADD "%RegPath%" /V Description /T REG_SZ /D "该区域中包含您公司 Intranet 上的所有网站。" /F

@echo 本地 Intranet区域设置

@REG ADD "%RegPath%" /V CurrentLevel /T REG_DWORD /D 0X0 /F


@REG add "%regpath%" /v "1001" /t reg_dword /d 0x00000001 /f
@REG add "%regpath%" /v "1004" /t reg_dword /d 0x00000001 /f
@reg add "%regpath%" /v "1200" /d "0" /t REG_DWORD /f
@REG add "%regpath%" /v "120B" /t reg_dword /d 0x00000003 /f
@REG add "%regpath%" /v "1201" /t reg_dword /d 0x00000001 /f
@reg add "%regpath%" /v "1208" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1209" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1400" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1402" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1407" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1405" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /v "1609" /d "0" /t REG_DWORD /f
@REG add "%regpath%" /v "1804" /t reg_dword /d 0x00000001 /f
@REG add "%regpath%" /v "1809" /t reg_dword /d 0x00000000 /f
@reg add "%regpath%" /v "2300" /d "0" /t REG_DWORD /f
@reg add "%regpath%" /V "2201" /d "0" /t REG_DWORD /f

@echo 受信任的站点区域

@REG ADD "%RegPath1%" /V CurrentLevel /T REG_DWORD /D 0X0 /F
@REG add "%regpath1%" /v "1001" /t reg_dword /d 0x00000001 /f
@REG add "%regpath1%" /v "1004" /t reg_dword /d 0x00000001 /f
@reg add "%regpath1%" /v "1200" /d "0" /t REG_DWORD /f
@REG add "%regpath1%" /v "120B" /t reg_dword /d 0x00000003 /f
@REG add "%regpath1%" /v "1201" /t reg_dword /d 0x00000001 /f
@reg add "%regpath1%" /v "1208" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1209" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1400" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1402" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1405" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1407" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /v "1609" /d "0" /t REG_DWORD /f
@REG add "%regpath1%" /v "1804" /t reg_dword /d 0x00000001 /f
@REG add "%regpath1%" /v "1809" /t reg_dword /d 0x00000000 /f
@reg add "%regpath1%" /v "2300" /d "0" /t REG_DWORD /f
@reg add "%regpath1%" /V "2201" /d "0" /t REG_DWORD /f

@echo Internet 区域设置
@REG ADD "%RegPath2%" /V CurrentLevel /T REG_DWORD /D 0X0 /F
@REG add "%regpath2%" /v "1001" /t reg_dword /d 0x00000001 /f
@REG add "%regpath2%" /v "1004" /t reg_dword /d 0x00000001 /f
@reg add "%regpath2%" /v "1200" /d "0" /t REG_DWORD /f
@REG add "%regpath2%" /v "1201" /t reg_dword /d 0x00000001 /f
@reg add "%regpath2%" /v "1208" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1209" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1400" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1402" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1405" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1407" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /v "1609" /d "0" /t REG_DWORD /f
@REG add "%regpath2%" /v "1804" /t reg_dword /d 0x00000001 /f
@REG add "%regpath2%" /v "1809" /t reg_dword /d 0x00000000 /f
@reg add "%regpath2%" /v "2300" /d "0" /t REG_DWORD /f
@reg add "%regpath2%" /V "2201" /d "0" /t REG_DWORD /f

@REG ADD "%RegPath%" /V Description /T REG_SZ /D "该区域中包含所有未放在其他区域中的网站" /F



@REG ADD "%RegPath%4" /V DisplayName /T REG_SZ /D "受限站点" /F

@REG ADD "%RegPath%4" /V Description /T REG_SZ /D "该区域中包含可能会损坏您的计算机或数据的网站。"" /F

@ECHO ActiveX权限设置完成

@echo. && @echo 去掉IE弹窗提醒...
@reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\New Windows" /v "PopupMgr" /d "0" /t REG_DWORD /f



@ECHO.&&ECHO 正在重启IE浏览器，请稍等......

::TASKKILL /IM iexplore.exe /T /F

@TASKKILL /IM iexplore.exe /F

@PING 127.0.0.1 -4 -n 5 >nul

@ECHO.&&ECHO.&&@ECHO IE使用环境配置完成。

@PING 127.0.0.1 -4 -n 5 >nul

EXIT

