@echo off
:start
echo 开启选项:
echo 1. kimi助手 ^& 秘塔搜索
echo 2. 视频下载/转换/封面/去水印
echo 3. Video/IMG/PDF处理
echo 4. 杂项 ^& 番茄时钟
echo 5. 在线听音乐
echo 6. LOFI
echo 7. 白噪音
echo 8. 影视/番剧
echo 9. 复制小游戏网页（适配手机）
echo 0. 退出

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    start "" /max /b "https://kimi.moonshot.cn"
    start "" /max /b "https://metaso.cn"
    cls
    goto start
) else if "%choice%"=="2" (
    start "" /max /b "https://snapany.com"
    start "" /max /b "https://convertio.co"
    start "" /max /b "https://online-video-cutter.com/cn/remove-logo"
    cls
    goto start
) else if "%choice%"=="3" (
    start "" /max /b "https://tinywow.com"
    start "" /max /b "https://tool.browser.qq.com/"
    cls
    goto start
) else if "%choice%"=="4" (
    start "" /max /b "https://pomodoro.zone/zh-cn/"
    cls
    goto start
) else if "%choice%"=="5" (
    start "" /max /b "https://bailemi.com/"
    start "" /max /b "https://tools.liumingye.cn/music/#/"
    cls
    goto start
) else if "%choice%"=="6" (
    start "" /max /b "https://lofifm.vercel.app/"
    cls
    goto start
) else if "%choice%"=="7" (
    start "" /max /b "https://www.rainymood.com/"
    cls
    goto start
) else if "%choice%"=="8" (
    start "" /max /b "https://www.keke2.app/"
    start "" /max /b "https://ddys.pro/"
    cls
    goto start
) else if "%choice%"=="9" (
    echo "https://poki.com" | clip
    cls
    goto start
) else if "%choice%"=="0" (
    exit
) else (
    cls
    goto start
)

@REM 基于Chromium的浏览器可以使用--kiosk 全屏化
@REM "C:\Program Files\Google\Chrome\Application\chrome.exe" --kiosk "http://www.example.com"
@REM 参考电脑王阿达提供网站
@REM https://www.kocpc.com.tw/archives/454499