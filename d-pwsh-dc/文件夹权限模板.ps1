
<#安全权限#>

# 安全权限设置为只读。
icacls "C:\共享文件夹\谢多意组" /grant "csylq\王诗语:(OI)(CI)(R)" /t # /t 表示递归

# 安全权限设置为编辑
icacls "C:\共享文件夹\樊小华" /grant "csylq\王诗语:(OI)(CI)(M)" /t

# 安全权限设置为读取、读取和执行、列出文件内容
icacls "C:\共享文件夹\谢多意组" /grant "csylq\王诗语:(OI)(CI)(RX)" /t

# 删除用户文件夹权限
icacls "C:\共享文件夹\谢多意组" /remove "csylq\王诗语" /t


<#共享权限#>

# 读写权限
Grant-SmbShareAccess -Name "樊小华组" -AccountName "csylq\王诗语" -AccessRight Change -Force


# 只读权限
Grant-SmbShareAccess -Name "谢多意组" -AccountName "csylq\王诗语" -AccessRight Read -Force

# 完全控制
Grant-SmbShareAccess -Name "朱爱梅组" -AccountName "csylq\王诗语" -AccessRight Full -Force

# 删除权限
Revoke-SmbShareAccess -Name "谢多意组" -AccountName "csylq\王诗语" -Force

<#
同一用户不能同时使用 -ReadAccess 和 -ChangeAccess，因为这会产生冲突。
你需要选择一种权限方式，要么是读取，要么是修改（Change 权限已经包含了读取权限）。
所以在这种情况下，给用户直接赋予 Change 权限就足够了，因为它包括读取和写入权限。
之所以精准定位是因为共享名称唯一，共享文件夹改名变成独立的非共享文件夹。

更多模板：https://www.cnblogs.com/suv789/p/18284489
#>