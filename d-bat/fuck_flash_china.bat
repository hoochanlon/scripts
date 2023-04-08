
@echo "将当前环境统一换成 C:\Windows\System32" 
@pushd C:\Windows\System32

@echo 正在下载 chromium87，请稍候....

@set chromium87_url="https://bluepload.unstable.life/selif/chromev870428088.exe"
@set chromium87="Chrome_V87.0.4280.88.exe"
@powershell -c "(New-Object System.Net.WebClient).DownloadFile('%chromium87_url%', '%userprofile%/Downloads/%chromium87%')"

@echo 正在下载flash，请稍候....

@set cleanflash_url="https://bluepload.unstable.life/selif/cleanflash3400282installer1.exe"
@set cleanflash="cleanflash3400282installer1.exe"
@powershell -c "(New-Object System.Net.WebClient).DownloadFile('%cleanflash_url%', '%userprofile%/Downloads/%cleanflash%')"

@echo
echo flash并不完全支持静默安装，将采取半自动安装模式

%userprofile%\Downloads\Chrome_V87.0.4280.88.exe

start /wait %userprofile%\Downloads\cleanflash3400282installer1.exe /S
