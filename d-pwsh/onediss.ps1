# 开启power shell脚本运行
# Set-ExecutionPolicy RemoteSigned -A 

# 挂载smb映射到驱动器，估计是做了好几层的代码处理，而且也没API，算了。

# 关闭休眠
powercfg /H off 

# 关闭UAC
New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

#开启smb1
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -A -N 

# 计算机图标，我的电脑，回收站
"rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0" | cmd

# Restart-Computer # 重启电脑

#---------
# 参考
# [net use 命令使用教程](https://blog.csdn.net/wcyyyyyyy/article/details/121533071)
# [如何使用Windows PowerShell禁用UAC？](https://qa.1r1g.com/sf/ask/670057391/)
# [程序员灯塔-命令行添加我的电脑图标到桌面](https://www.wangt.cc/2020/11/命令行添加我的电脑图标到桌面/)
# [windows7系统批处理删除桌面图标，有我的电脑，网上邻居，我的文档，控制面板](https://zhidao.baidu.com/question/1884005585197150228.html)
# [cnblogs-PowerShell添加或修改注册表开机启动项脚本](https://www.cnblogs.com/bonelee/p/16033759.html)
# [码农家园-关于注册表：使用PowerShell导入脚本修改的.reg文件？](https://www.codenong.com/6289085/)
# [bbsmax-Powershell学习之道-文件夹共享及磁盘映射](https://www.bbsmax.com/A/8Bz8pP1Ozx/)