# 使用说明
# 下载到本地使用，需转成 GB2312 编码，否则中文乱码
Function Get-WebsiteHex(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$website
    )

    # 去除网址中的 https:// 和 http:// 前缀
    $website = $website -replace "https?://", ""

    # 去除斜杠后的所有内容
    $website = $website -replace "/.*"

    # 计算网站名称的十六进制长度
    $hex_length = [BitConverter]::ToString([BitConverter]::GetBytes([int16]$website.length)).replace('-','')
    # 将网站名称转换为十六进制数据
    $hex_data = ([System.Text.Encoding]::Unicode.GetBytes($website) | ForEach-Object { "{0:X2}" -f $_ }) -join ""
    return "0C000000000000000000000101000000$hex_length$hex_data"
}

Function Get-IECompatibilityViewHexHeader(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$websites
    )

    # 构建 IE 兼容性视图的头部
    return ("411F00005308ADBA{0}FFFFFFFF01000000{0}" -f ([BitConverter]::ToString([BitConverter]::GetBytes([int32]$websites.count)).replace('-','')))
}

Function Get-IECVHex(){
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$websites,
        [switch]$ReturnBytes
    )

    # 获取每个网站的十六进制表示，并将它们连接起来
    $siteArray = $websites -split "[, ]" | Where-Object { $_.Trim() -ne '' }
    $hex_website = $siteArray | ForEach-Object { Get-WebsiteHex $_ }
    $hex_result = ("411F00005308ADBA{0}FFFFFFFF01000000{0}$hex_website" -f [BitConverter]::ToString([BitConverter]::GetBytes([int32]$siteArray.count)).replace('-','')) -replace " "

    if( $ReturnBytes ){
        # 如果传入了 "-ReturnBytes" 开关，则返回字节数组
        [byte[]]$bytes = @()
        for( $n=0; $n -lt $hex_result.length; $n += 2 ){
            $bytes += ([Convert]::ToInt64($hex_result.substring($n,2),16))
        }
        return $bytes
    }else{
        # 否则，返回十六进制字符串
        return $hex_result
    }
}

Write-Host ""
$websites = Read-Host "请输入想要IE兼容视图的网址"
# 从用户输入中获取网址并调用 Get-IECVHex 函数
Write-Host "`n 所有相关网址的hex值已生成，复制如下指令即可： `n"
Write-Host 'reg add "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /v "UserFilter" /t REG_BINARY /d ' -NoNewline
Get-IECVHex -websites $websites

# 参考链接：
# * [Windows Powershell进阶(43) 注册表操作之IE兼容性视图](https://chaoyuew.gitee.io/WPS-43-Advanced-Modifying-IE-Compatibility-View-Settings-with-Powershell.html)
# * [Jeff's Blog - MODIFYING IE COMPATIBILITY VIEW SETTINGS WITH POWERSHELL](http://jeffgraves.me/2014/02/19/modifying-ie-compatibility-view-settings-with-powershell/)
# * [csdn - IE浏览器兼容性视图设置数据解析](https://blog.csdn.net/thb_cn/article/details/125124565)
