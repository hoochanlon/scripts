# GB2312
echo " "
echo "win11家庭版会自动升级成专业版，win11 Pro及其他版本系统将直接启动Windows/Office的相关激活入口"
echo "注意：在家庭版在升级过程期间，电脑会自动重启完成升级，所以需要再次运行指令两次"
echo " "
# [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("asdasd"));
# 获取系统版本，转字符串嘛
$winv=""+(gwmi win32_operatingsystem |% caption)
$win_v_home="Microsoft Windows 11 家庭版"
# 解码输出
$up_key = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("VgBLADcASgBHAC0ATgBQAEgAVABNAC0AQwA5ADcASgBNAC0AOQBNAFAARwBUAC0AMwBWADYANgBUAA=="))
if($winv -eq $win_v_home){
# sc config配置开机自启；LicenseManager=启动注册管理；wuauserv=Windows Update 服务。
$x="sc config LicenseManager start= auto & net start LicenseManager"
$y="sc config wuauserv start= auto & net start wuauserv"
$z="changepk.exe /productkey "+$up_key
# 通过管道符传输至CMD
$x,$y,$z|cmd
}
# curl 获取远程脚本通过管道传输至服务器。
irm https://massgrave.dev/get | iex
# 删除当前脚本
remove-item $MyInvocation.MyCommand.Path -force

#----------------------------------------------------------------------------------------
#
#
# 参考资料
# http://xahlee.info/powershell/powershell_flow_control.html
# 获取系统版本，参考：https://qa.1r1g.com/sf/ask/513113121/
## 找到了获取系统版本的方法，就不用静态变量 $global:i = 1;i++; 整活了。
# cmd SC命令，参考： 
## https://www.cnblogs.com/wiseblog/articles/14932469.html
# powershell与cmd切换，参考参考：
## https://www.codenong.com/24940243/
#
#------------------------------------------------------------------------------------------

