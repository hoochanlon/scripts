@echo off
rem 网络共享文件夹文件拷贝到本地
xcopy /s /y  "\\172.16.1.254\it\hosts" "C:\Windows\System32\drivers\etc"

echo 文件拷贝完成，显示hosts 文本内容
type C:\Windows\System32\drivers\etc\hosts
pause
