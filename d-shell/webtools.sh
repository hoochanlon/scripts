#!/bin/bash

while :
do
    echo "开启选项:"
    echo "1. kimi助手 & 秘塔搜索"
    echo "2. 视频下载/转换/封面/去水印"
    echo "3. Video/IMG/PDF处理"
    echo "4. 杂项 & 番茄时钟"
    echo "5. 在线听音乐"
    echo "6. LOFI"
    echo "7. 白噪音"
    echo "8. 影视/番剧"
    echo "9. 复制小游戏网页（适配手机）"
    echo "0. 退出"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            (open "https://kimi.moonshot.cn" &)
            (open "https://metaso.cn" &)
            ;;
        2)
            (open "https://snapany.com" &)
            (open "https://convertio.co" &)
            (open "https://online-video-cutter.com/cn/remove-logo" &)
            ;;
        3)
            (open "https://tinywow.com" &)
            (open "https://tool.browser.qq.com/" &)
            ;;
        4)
            (open "https://pomodoro.zone/zh-cn/" &)
            ;;
        5)
            (open "https://bailemi.com/" &)
            (open "https://tools.liumingye.cn/music/#/" &)
            ;;
        6)
            (open "https://lofifm.vercel.app/" &)
            ;;
        7)
            (open "https://www.rainymood.com/" &)
            ;;
        8)
            (open "https://www.keke2.app/" &)
            (open "https://ddys.pro/" &)
            ;;
        9)
            echo "https://poki.com" | pbcopy
            ;;
        0)
            exit
            ;;
        *)
            ;;
    esac

    clear
done
