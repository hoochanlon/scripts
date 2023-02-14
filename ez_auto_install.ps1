# 说明
# 对福昕PDF阅读器同类别的打包方式程序，静默不起作用；钉钉正常。
echo "提示：把需要自动安装的软件，拷贝到下载目录文件夹即可。"

# foreach遍历目录
$rawPath = "C:${Env:\HOMEPATH}\Downloads\";
$allFile = Get-ChildItem -Path $rawPath;
foreach ($file in $allFile)
{
# 转成文件路径字符串。
$softname="C:${Env:\HOMEPATH}\Downloads\"+$file.name
# Write-Host $softname
Start-Process -Wait -FilePath $softname -ArgumentList '/S /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /FORCE' -PassThru
}
echo "ok"
# [cnblogs-powershell 遍历目录](https://www.cnblogs.com/068XS228/p/15466163.html)
# [cnblogs-Windows软件静默安装 ](https://www.cnblogs.com/toor/p/4198061.html)
# [csdn-如何在Windows PowerShell中获取当前的用户名？](https://blog.csdn.net/CHCH998/article/details/107726143)
# [cnblogs-提高GitHub的访问速度](https://www.cnblogs.com/lemonguess/p/15143645.html)