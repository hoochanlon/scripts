# 发现一个升级的aiu文件，删不删随喜吧，"C:\ProgramData\Emurasoft\EmEditor\updates\emed64_updates4u.aiu"
# 摇骰子1～6点随机选一个 emeditor key。
# $emeditor_v21_str;$getkey; 重复定义增加多余的输出显示
$i =  (1..6|Get-Random)
$emeditor_v21_str = switch ($i)
{
1 {"RABNAEEAWgBNAC0AVwBIAFkANQAyAC0AQQBYADIAMgAyAC0AWgBRAEoAWABOAC0ANwA5AEoAWABIAA=="}
2 {"RABTAEIAWgBHAC0AQgBGADIAWABIAC0ATQA5ADIAMgAyAC0ARAA1AE0AOABMAC0AUQBDAEMAWABIAA=="}
3 {"RABNAEEAWgBFAC0AVgBLAFoASgBWAC0AMgA4AFoAWgBaAC0ANABUADcAQQBKAC0ANwBIAEgANQA1AA=="}
4 {"RABQAEEAWgA2AC0AUwBIADIAVQBQAC0AUwA3AFoAWgBaAC0AWAA0ADcAVABVAC0ARgBVAEwAMgBYAA=="}
5 {"RABTAEgAWgBBAC0AUQBKADMARwBXAC0AWQBVAFoAWgBaAC0AUwBWAEYAWgAyAC0ANgBEAEIAVQBFAA=="}
6 {"RABNAEEAWgBNAC0AWgBNADUANQA2AC0ASwA2AFoAWgBaAC0AOQA5AEwAVwA4AC0AVwBWADUAQgBUAA=="}
}

# 编码测试 [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("asdasdxzczc"));
$getkey = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($emeditor_v21_str))
Set-Clipboard -Value $getkey # Get-Clipboard

Write-Output ""
Write-Output "注册名字随便填一个，序列号粘贴进去就行了。序列号已复制到粘贴板：" $getkey
Write-Output ""
Write-Output "xp/win7/server2008请下载：http://files.emeditor.com/emed32_14.8.1.exe"
Write-Output ""
Write-Output "win10/win11及未来更高版本以上：https://support.emeditor.com/en/downloads/latest/installer/64"

# iwr https | iex 倒是不用再删除自身了
# utf8显示中文会出问题
# remove-item $MyInvocation.MyCommand.Path -force #删除脚本自身

<# 

编码：GB2312，Mac调试powershell注意换回UTF8

参考链接：

https://www.educba.com/powershell-base64/
https://www.52pojie.cn/thread-658917-1-1.html
https://www.52pojie.cn/forum.php?mod=viewthread&tid=578165
https://www.cnblogs.com/estherlty/p/15771219.html
https://www.bilibili.com/read/cv19068695
https://www.baidu.com/s?wd=emeditor
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard
https://learn.microsoft.com/zh-cn/powershell/scripting/learn/deep-dives/everything-about-switch
http://zhishichong.com/article/47563

| DUANG～ 嘎得 KEY | 抛瓦拜 一群网友们|
|:---------------------------------------------------------:|
|DMAZM-WHY52-AX222-ZQJXN-79JXH|DSBZG-BF2XH-M9222-D5M8L-QCCXH|

#>