@REM 在PE环境里对注册表的查询操作存在路径不全的识别问题
@REG LOAD HKLM\TempLookIp C:\Windows\System32\config\SYSTEM
@REM 递归查询
@REG QUERY HKLM\TempLookIp\ControlSet001\services\Tcpip\Parameters\interfaces /s

@pause
