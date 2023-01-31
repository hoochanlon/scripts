### 一键下载安装及注册WinRAR

以管理员运行cmd

```batch
powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```

脚本功能

```batch
: 调用powershell模块下载，用explorer.exe也行，只不过会调用浏览器下载而已
powershell -command Invoke-WebRequest -Uri "https://www.win-rar.com/fileadmin/winrar-versions/sc/sc20220317/wrr/winrar-x64-611sc.exe" -OutFile "C:/Users/${env:UserName}/Downloads/winrar-x64-611sc.exe"

: 静默安装，用户/下载目录
start /wait C:\Users\%username%\Downloads\winrar-x64-611sc.exe /S

: 写入注册文件，注册信息来自网络公开
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
```
