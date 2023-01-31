
@echo "注意：需以管理员权限运行该winRAR一键下载安装注册激活脚本。"
@echo
@echo "替换国内代理个人含广告版，下载官方镜像简中商业版WinRAR。（下载位置在C盘里的下载目录）。"

@echo off
powershell -command Invoke-WebRequest -Uri "https://www.win-rar.com/fileadmin/winrar-versions/sc/sc20220317/wrr/winrar-x64-611sc.exe" -OutFile "C:/Users/${env:UserName}/Downloads/winrar-x64-611sc.exe"

@echo "静默安装WinRAR，并写入注册文件。"

start /wait C:\Users\%username%\Downloads\winrar-x64-611sc.exe /S

@echo off
(
echo RAR registration data
echo State Grid Corporation Of China
echo 50000 PC usage license
echo UID=5827a0bd1c43525d0a5d
echo 64122122500a5d3d56f784f3a440ac3fb632d34e08bbaa37fc7712
echo 6acaeb8eb044810272e86042cb7c79b1da0eaf88c79f8a7c6dd77b
echo dba335e27a109997ac90fb0e10e4129e79f46c42b4ee1832fa5113
echo 7443fcc1124840d4dd36f3af84a5c915a760b18c6394f938168227
echo fbf29edbc4b34ef85ee53fbfca71814a82afadf073876b4b033451
echo b6292a7cc7975b3ff3cc73404abbf7c126787344169eeae4609f62
echo c9ffbc159bf2640ad5d9b88f8fa9d9cbf2b7e5b022a21938465244
)>C:\"Program Files"\WinRAR\rarreg.key


@echo "激活去广告已完成，按回车或点叉关闭该窗口。"
pause

del %0

:: 其他说明
:: 之前的WinRAR软件需安装默认目录。
:: 编码：GB2312；换行：CRLF。修复注释造成命令字母缺失及乱码问题。
:: explorer.exe也用于下载，但写出有效代码太麻烦了。
:: 非管理员的CMD，写入到C盘的Program Files文件不成功。
:: win7需要额外安装powershell5.0以及TLS/SSL管理工具。