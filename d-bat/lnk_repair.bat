@echo off

REM (1)桌面图标变成lnk、(2)桌面快捷方式变成lnk、(3)桌面图标都变成ie
REM https://www.hnit.edu.cn/wlzx/info/1007/1224.htm

REM 设置.lnk关联
reg add "HKCR\.lnk" /ve /d "lnkfile" /f

REM 设置.lnkshellex项
reg add "HKCR\lnkfile\shellex" /ve /d "" /f

REM 设置.lnkshellnew项
reg add "HKCR\lnkfile\shellnew" /v "command" /t REG_SZ /d "rundll32.exe appwiz.cpl,newlinkhere 1" /f

REM 设置lnkfile项
reg add "HKCR\lnkfile" /ve /d "快捷方式" /f
reg add "HKCR\lnkfile" /v "editflags" /t REG_DWORD /d 1 /f
reg add "HKCR\lnkfile" /v "isshortcut" /t REG_SZ /d "" /f
reg add "HKCR\lnkfile" /v "nevershowext" /t REG_SZ /d "" /f

REM 清空其他项（可根据需要添加对应的项）
reg delete "HKCR\lnkfile\clsid" /f
reg delete "HKCR\lnkfile\shellex" /f
reg delete "HKCR\lnkfile\shellex\contextmenuhandlers" /f
reg delete "HKCR\lnkfile\shellex\contextmenuhandlers\offline files" /f
REM  代表了快捷方式的上下文菜单处理程序，当用户右键单击一个快捷方式时，系统将调用与之关联的上下文菜单处理程序来执行特定的操作。
reg delete "HKCR\lnkfile\shellex\contextmenuhandlers\{00021401-0000-0000-c000-000000000046}" /f
reg delete "HKCR\lnkfile\shellex\handler" /f
reg delete "HKCR\lnkfile\shellex\iconhandler" /f
reg delete "HKCR\lnkfile\shellex\propertysheethandlers" /f
reg delete "HKCR\lnkfile\shellex\propertysheethandlers\shimlayer property page" /f

echo 转换完成！
pause
