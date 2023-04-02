@echo off
@REM ----- 下载与配置 --------------

@REM 下载 exiftool.zip
IF NOT EXIST "C:\Users\%USERNAME%\Downloads\exiftool.zip" curl -o C:\Users\%USERNAME%\Downloads\exiftool.zip https://exiftool.org/exiftool-12.59.zip 

@REM  “找不到中央目录结尾记录”，那是存档坏了，见：https://qa.1r1g.com/sf/ask/1467228241/
@REM  判断位置是否存在，解压缩并重命名
IF NOT EXIST C:\Users\%USERNAME%\Tools\exiftool.exe ^
powershell -c "Expand-Archive C:/Users/${env:UserName}/Downloads/exiftool.zip C:/Users/${env:UserName}/Tools/ -Force"&&ren C:\Users\%USERNAME%\Tools\exiftool(-k).exe exiftool.exe > nul

@REM echo 文件保存位置：C:/Users/%USERNAME%/Tools 
echo "exiftool下载与配置，已完成"

@REM ----- 使用示例 --------------
:LOOP

@REM 1. 部分系统终端默认变量目录不同
@REM 2. 单个图片演示

set /p data=请将图片或目录路径复制到终端，或输入 exit 可退出当前程序: 

IF "%data%"=="exit" GOTO END

IF EXIST %data%\ (

    @REM %%~nxf %nameonly% %extonly% %filename%
    for %%f in ("%data%\*.jpg" "%data%\*.png" "%data%\*.jpeg") do (
        echo 删除文件 "%%~nxf" 中的 ICC_PROFILE...
        C:\Users\%USERNAME%\Tools\exiftool.exe -overwrite_original -icc_profile= %%f > nul
    )

)

IF EXIST %data% (C:\Users\%USERNAME%\Tools\exiftool.exe -overwrite_original -icc_profile= %data%) else (echo "信息有误，不存在图片内容" )

GOTO LOOP
:END

echo 图片处理程序，已退出



@REM -------- 调试代码（win11调用旧版照片查看器） ------------

@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t reg_sz /d "PhotoViewer.FileAssoc.Tiff" /f
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t reg_sz /d "PhotoViewer.FileAssoc.Tiff" /f
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t reg_sz /d "PhotoViewer.FileAssoc.Tiff" /f
