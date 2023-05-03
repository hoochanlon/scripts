# ------- crontab说明 ----------
# crontab - 告诉 crontab 命令从标准输入读取数据，而不是从文件读取数据。
# \ 将命令拆分成多行。注意到反斜杠后面不能有空格或其他字符。
# crontab -e: 编辑当前用户的cron表
# crontab -l: 列出当前用户的cron作业；crontab -r: 删除当前用户的cron表 
# ------- crontab说明 ----------


#----- 定时切换壁纸 -------------

# 导出当前定时作业
# crontab -l > my_desktop_cron

# 加入前提说明
printf "\n温馨提示 \n"
printf "\n macOS系统壁纸目录：/System/Library/Desktop Pictures/ "
printf "\n 自定义的壁纸目录文件不要自行删除，造成脚本执行异常。"
printf "\n 若曾有添加过定时任务，请用 crontab -l 查看详情，或酌情 crontab -r 清除任务表 \n\n"

# 设置终端读取变量
read -p "1. 将自定义壁纸拖入到终端: " diy_wallpaper
printf "\n" 
read -p "2. 将系统壁纸拖入到终端: " sys_wallpaper
printf "\n" 

# 保持原样写代码
cat <<EOF > my_desktop_cron
# 周一傍晚六点半，自定义壁纸
30 18 * * 1 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$diy_wallpaper"'

# 周一至周四，晚上休息时间十二点十分，切换系统壁纸
10 24 * * 1-4 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$sys_wallpaper"'

# 周五傍晚六点半，自定义壁纸
30 18 * * 5 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$diy_wallpaper"'

# 周日晚上休息时间十一点十分，切换系统壁纸
10 23 * * 7 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$sys_wallpaper"'
EOF

# 设置定时任务
crontab my_desktop_cron

# 移除该临时文件
rm my_desktop_cron

# 测试打印
printf "定时壁纸任务已完成。\n"
echo ""

# 删除自身
rm -rf $0

#----- 定时切换壁纸 -------------


# ------ 其他测试项 -------------

# 每隔三十天换一次壁纸，“x/30” 从x天之后的30天
# echo "0 0 */30 * * osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \
# \"~/Pictures/必应壁纸/KlostersSerneus-20230502.png\"'" \
# | crontab -

# ------ 其他测试项 -------------
