### 激活Windows

以管理员运行cmd，一键起飞

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/win11_htp_active_lite.ps1&&TIMEOUT /T 1&&start /b powershell win11_htp_active_lite.ps1
```

以管理员运行powershell，一键起飞

```
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/win11_htp_active_lite.ps1 -Outfile win11_htp_active_lite.ps1 | powershell -c win11_htp_active_lite.ps1
```

### 注册WinRAR

以管理员运行cmd，一键下载安装及注册WinRAR

```batch
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/winrar_down_reg.bat&&TIMEOUT /T 1&&start /b winrar_down_reg.bat
```

注释版示例

```
# curl -O https://ghproxy.com/https://raw.githubusercontent.com/
# hoochanlon/ihs-simple/main/winrar_down_reg.bat&&TIMEOUT /T 1&&
# start /b C:\Users\%username%\Downloads\winrar_down_reg.bat
```


### 注册emeditor

cmd的curl下载，文件默认会在命令行所在当前目录（管理员权限 /system32，平常打开 /用户名），powershell和管理员的界面默认会从system32里找文件，所以也能容易出错。

```
curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/emeditor_random_keygen.ps1&&powershell -c emeditor_random_keygen.ps1
```

附龟速下载

```powershell
(new-object System.Net.WebClient).DownloadFile("https://support.emeditor.com/en/downloads/latest/installer/64","c:/editor.exe")
```


### 注册xchange pdf

powershell以管理员权限运行。注意当前目录，curl输出到当前所在目录，powershell的命令会在system32找文件或命令，自然就会报错了。

```
curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
```
