@REM  防IE劫持edge修改回默认EDGE

@echo off
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /f
reg delete "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /f
reg delete "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /f
reg delete "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_DISABLE_IE11_SECURITY_EOL_NOTIFICATION" /v "iexplore.exe" /f

pause
del %0
