<# 共享权限 #>

# 读写权限
Grant-SmbShareAccess -Name "樊小华组" -AccountName "csylq\王诗语" -AccessRight Change -Force

## 只读权限
Grant-SmbShareAccess -Name "谢多意组" -AccountName "csylq\王诗语" -AccessRight Read -Force

<# 安全权限 #>

# 安全权限设置为只读。
icacls "C:\共享文件夹\谢多意组" /grant "csylq\王诗语:(OI)(CI)(R)" /t # /t 表示递归

# 安全权限设置为编辑
icacls "C:\共享文件夹\樊小华" /grant "csylq\王诗语:(OI)(CI)(M)" /t