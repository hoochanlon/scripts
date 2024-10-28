# 设置输入和输出文件路径
$inputFile = "C:\Users\Administrator\Desktop\添加用户.txt"
$outputFile = "C:\Users\Administrator\Desktop\inode_exportAccount.txt"

# 如果输出文件已经存在，先清空内容
if (Test-Path $outputFile) {
    Clear-Content $outputFile
}

# 读取输入文件的每一行并处理
Get-Content $inputFile -Encoding UTF8 | ForEach-Object {
    $name = $_.Trim()  # 去除前后的空格或换行符
    if ($name -ne "") {  # 确保行不为空
        $formattedName = "$name $name 消费业务 Mima12345 $name 生产专用(最终版)"
        # 将格式化后的字符串写入输出文件
        Add-Content -Path $outputFile -Value $formattedName
    }
}

Write-Host "名字处理完成，结果已写入到 $outputFile"
