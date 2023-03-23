@REM 已知深信服web端上网登录
@REM curl -d "opr=pwdLogin&userName=panxing&pwd=20200818&rememberPwd=0" http://10.100.0.1/ac_portal/login.php

@REM [脚本之家-批处理bat系统管理之任务计划篇](https://www.jb51.net/article/266021.htm)
@REM [IT天空-schtasks命令中时间设置的问题 ](https://www.itsk.com/thread-419628-1-1.html)
@REM [cnblogs-转：[windows]DOS批处理添加任务计划](https://www.cnblogs.com/shy1766IT/p/6391967.html)

@REM 转义，加倍双引号，powershell可行，批处理不可行。
@REM 批出处理换行 ^；powershell换行 `n；这里以批处理为准


@REM 查询与删除
@REM schtasks /query /tn "内网认证请求"
@REM schtasks /delete /tn "自启内网上网请求" /f
@REM schtasks /run /tn "自启内网上网请求"


@REM /sc weekly  /d MON,TUE,WED,THU,FRI 周一至周五
@REM Windows计划任务（手动执行脚本正常，定时执行不生效）注意默认是“只有在计算机使用交流电源时才启动此任务”

@REM 远程指令调用测试
curl -d "opr=pwdLogin&userName=huchenglong&pwd=20200819&rememberPwd=0" http://10.10.10.1/ac_portal/login.php 

echo curl -d "opr=pwdLogin&userName=huchenglong&pwd=20200819&rememberPwd=0" http://10.10.10.1/ac_portal/login.php > C:\auto_request.bat
schtasks /create /tn "自启内网上网请求" /tr C:\auto_request.bat /sc weekly /d MON,TUE,WED,THU,FRI /st 13:49:00 /ru System



