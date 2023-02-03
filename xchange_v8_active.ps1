$setsume = "
`n
 ==ROFL:ROFL:ROFL:ROFL== #-----------------------------------简单说明----------------------
         _^___
 L    __/   [] \      1. v8在2022.7.31维护到期，但可永久激活，不能升级 。
LOL===__        \     2. v9不再支持国内激活，OCR略有提升，详见：www.tracker-software.com/sales-are-suspended
 L      \________]    3. v8版本官网下载地址：https://downloads.pdf-xchange.com/PDFXVE8.zip
         I   I        
        --------/       #-------------------------------------------------------------------
`n
"

echo $setsume
echo “正在从官网下载文件：xchange PDF Editor(Version 8)”
curl  https://downloads.pdf-xchange.com/PDFXVE8.zip -OutFile ${Env:\HOMEPATH}\downloads\PDFXVE8.zip
echo "自动化解压与安装软件，并生成软件注册码。"
Expand-Archive ${Env:\HOMEPATH}/downloads/PDFXVE8.zip -DestinationPath ${Env:\HOMEPATH}\downloads\  -Force
$xchangepdf_okey_v8=[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("UABFAFAAOAAwAC0AcgBjADMAeQBNAGIAUgBZADgAagBtAHIAWAA1AHIAYgBwAEYAbwBmADMAegBYAFEALwAwADMASgBNAEoAWAArADkAMQB2AE8ANABtAEYAKwByAHMAZgBRADEAMQBCADMAbQBHAE0ARQBiAEYAVQA1AHcAaABwAHIAMQBBAHcAYwAKAFUAdQB0AHMARwBwAG0AYwB3ADUAaQBsADUATQBlAGsAKwBZAE8AZABpAG8AWABzADkAeQA1AHcASgBXAEMAcABRAGUARQByAFQAcABpAEoAegBzAHAARABmAEwAawBXADYAYQBlAFQAVwBlAEoAUwBCAFIAOABQAFUAdgBxADYAegBuAHcAcQB0ADkAVwBsADkATABlADMAaABuAGsAbQAKAFcAYwAzAEUATQBSAEYAZgBUAHQAZABLAEkAMQBZAHoAWgBzAHIAVAAyAEQAUABYADAARwAyAHkAagB0AHcAVwBoADAAVQA4AFYAYgBtAE0ASQBWAEsAWQBtAGQASgBqADAAVgA3AEcAVgBnAFIATwBNAG8ARQA5AHcAVABMADUAVAB2AHMAQQBOAEYAaQBwAGcAOQBwAG8ATgBlAG8AcQAKAEsAOQA2AHYASgBiAHYATgB4AGsANgBvAEIAQQBmADMAVQB4AHYAbgB0AEUAdQB3AFUATgA4ADkAMABRAGMAQgBRAHgAeABnADcAbwB6AHQAeABCAFoAQwA5AEMAdQBUAGIAVABWAFMAUwA2AGQAaABoAFMAUAA0AHAAQgB0AG0ALwAxAEEARABPAGgAMgBnAE0AMAA1ADgAbQBmADgAQwAKAEQAYQAvAE8AWABkAHIAegA1AHoAbwBGAGgAZgBsAE4AVwBjAEwAbQB0AEEANQBJAEwARQBuADYAYwBzAGQAdgBuAEcAdQBHAEgAWQAxAGMAZAByAG0AMAByAEYALwBDAE0AWABJAEsAbgBFAGkAbQBIAGUAWQBwADYAagBEAG4AegBUADkATQAxAFQANABYADQASgBiAHYAUgB3AD0A"))
echo $xchangepdf_okey_v8 > ${Env:\HOMEPATH}\downloads\xchangepdf_v8.lic
Start-Process ${Env:\HOMEPATH}'\downloads\PDFXVE8.exe' /S -NoNewWindow -Wait -PassThru
Set-Clipboard -Value $xchangepdf_okey_v8
echo “license已写入粘贴板，打开软件复制进去即可，后续也可在软件解压目录中查看。”
remove-item $MyInvocation.MyCommand.Path -force 

#------------------------------------------------------------------------------------------------------

# 下载方式
# * https://blog.csdn.net/EadderYin/article/details/120573622 
# * https://learn.microsoft.com/zh-cn/powershell/module/Microsoft.PowerShell.Utility/Invoke-WebRequest
# 解压
# * https://blog.csdn.net/m0_60558800/article/details/123759719
# 静默安装
# * https://www.likecs.com/ask-6192544.html
# 静默卸载
# * https://qastack.cn/programming/113542/how-can-i-uninstall-an-application-using-powershell
# * https://www.pstips.net/powershell-uninstall-software.html

#------debug-----
# 卸载
# 根据名称：(Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "PDF-XChange Editor" }).uninstall()
# 根据注册ID：(Get-WmiObject -Class Win32_Product | Where-Object {$_.IdentifyingNumber -eq "{E05F4C70-890B-429C-B24D-36AB434F4991}" }).uninstall()
#-----------------

#------------------------------------------------------------------------------------------------------