echo " "
echo "win11家庭版会自动升级成专业版，win11 Pro及其他版本系统将直接启动Windows/Office的相关激活入口"
echo "注意：在家庭版在升级过程期间，电脑会自动重启完成升级，所以需要再次运行指令两次"
echo " "
# 获取系统版本，再转字符串嘛
$winv=""+(gwmi win32_operatingsystem |% caption)
$win_v_home="Microsoft Windows 11 家庭版"
$up_key = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("VgBLADcASgBHAC0ATgBQAEgAVABNAC0AQwA5ADcASgBNAC0AOQBNAFAARwBUAC0AMwBWADYANgBUAA=="))
if($winv -eq $win_v_home){
# sc config配置开机自启；LicenseManager=启动注册管理；wuauserv=Windows Update 服务。
$x="sc config LicenseManager start= auto & net start LicenseManager"
$y="sc config wuauserv start= auto & net start wuauserv"
$z="changepk.exe /productkey"+$up_key
# 通过管道符传输至CMD
$x,$y,$z|cmd
# 配置开机自启执行 powershell
set-location HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce
new-itemproperty . MyKey -propertytype String -value "Powershell c:\code.ps1" -force
# 延时调试
# Start-Sleep -Seconds 3

}else{
# 删除开机自启的注册项 mykey
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce | findstr "MyKey"
if ($? -eq "True"){reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v MyKey /f}

# curl 获取远程脚本通过管道传输至服务器。新的程序运行。
irm https://massgrave.dev/get | iex
}


#------------------------------------------------------------------------------------------
#
# 关键部分参考：
#
## Powershell 添加开机启动项：https://blog.csdn.net/zhouyingge1104/article/details/122454953
## powershell 开机只运行一次：https://www.it1352.com/2339670.html
## powershell 去除开机启动项：https://blog.csdn.net/weixin_34270606/article/details/93126549
## powershell set-location https://www.yiibai.com/code/detail/15308
## 计划任务运行powershell脚本如何避免窗口闪现？：https://zhidao.baidu.com/question/928430296880486339.html
## powershell以管理员权限运行： https://www.yiibai.com/powershell/powershell-run-as-administrator.html
## powershell类似&&的操作：https://www.codenong.com/48812879/
#
# 解码注释，方便一次性拿来用 
# [System.Text.Decoding]::Unicode.GetString([System.Convert]::FromBase64String("")) 
#------------------------------------------------------------------------------------------
#
# 新的发现
## 重新再打开时以管理员身份运行，删除脚本自身，不过这已经是上升漏洞攻防研究的问题了。
## 个人理解：如果这样做，敲几个命令就能搞定，简单可行的话，那这系统可就危险了。
## 所以综上是会堵住的。
#
# 其他参考
## 流程控制：http://xahlee.info/powershell/powershell_flow_control.html
# 获取系统版本，参考：https://qa.1r1g.com/sf/ask/513113121/
## 找到了获取系统版本的字符串的实例方法，就不用静态变量 $global:i = 1;i++; 整活了。
# cmd SC命令，参考： 
## https://www.cnblogs.com/wiseblog/articles/14932469.html
# powershell与cmd切换，参考参考：
## https://www.codenong.com/24940243/
#
#------------------------------------------------------------------------------------------




# irm https://massgrave.dev/get | iex
