我·分析完必应搜索的html，虽已知道壁纸URL规律，不过找到了 [ioliu-每日必应壁纸站](http://bing.ioliu.cn)  ，它让我没什么动力写爬虫了。不过，我想借此完成早前一闪而过小点子 —— “每天上下班时间段，各一副壁纸，一面工作，一面生活，工作和生活互不干扰。

## 启动前探究

###  基础指令测试

Mac系统壁纸位置，以Monterey为例（还原准备）

```
/System/Library/Desktop Pictures/Monterey Graphic.heic
```

每晚七点执行一次

```shell
0 19 * * * osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/path/to/image.jpg"'
```

周一至周五晚七点执行一次

```
0 19 * * 1-5 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/image.jpg"'
```

### 需求环境及指令考量

#### 设：晚上休息时间十一点十分，切换系统壁纸；傍晚六点半，自定义壁纸。

（原始需求如上，以下是边分析边改进）

**周一傍晚六点半，自定义壁纸**

```
30 18 * * 1 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/diy.jpg"'
```

**周一至周四，晚上休息时间十一点十分，切换系统壁纸**

```
10 23 * * 1-4 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Monterey Graphic.heic"'
```

**周五傍晚六点半，自定义壁纸**

```
30 18 * * 5 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/diy.jpg"'
```

**周日晚上休息时间十一点十分，切换系统壁纸**

```
10 23 * * 7 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Monterey Graphic.heic"'
```

**每隔三十天换一次壁纸**

```
# “x/30” 从x天之后的30天
0 0 */30 * * osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/diy.jpg"'
```

## 遇到的问题（测试异常结果分析）

**总结的四点**：

1. Mac使用`crontab -e` 的前置条件：一、换nano，二、 `brew install nvim`
2. 理论上，macOS当屏幕锁定或休眠，系统在锁定或休眠会将大部分进程挂起，不会运行 `crontab` 中的任务，以达到减小开支及省电目的；但我的测试：Mac充电状态、放电状态的息屏，解锁后还是会更改的，实际上亮之前就已经改了。如果是关机的话，时间就跳过待下一次这个时间点了。
3. 使用 `launchd` ，编写个 plist 文件，加入守护进程。效果上也没多大差异，而且编码复杂度过高，不划算，故没考虑在内。
4. `crontab`是以当前用户执行的，sudo 之后会临时变成root，应使用`sudo -u $USER `，保持当前用户名执行。

**其他问题** 试用如下代码逐条添加定时任务，并不会追加，而是覆盖刷新。

```
# 周一傍晚六点半，自定义壁纸
echo "30 18 * * 1 osascript -e 'tell application \"Finder\" \
to set desktop picture to \
POSIX file \"~/Pictures/必应壁纸/KlostersSerneus-20230502.png\"'" \
| crontab -

# 周一至周四，晚上休息时间十一点十分，切换系统壁纸
echo "10 23 * * 1-4 osascript -e 'tell application \"Finder\" \
to set desktop picture to \
POSIX file "/System/Library/Desktop Pictures/Monterey Graphic.heic"'" \
| crontab -

# 说明
# crontab - 告诉 crontab 命令从标准输入读取数据，而不是从文件读取数据。
# \ 将命令拆分成多行。注意到反斜杠后面不能有空格或其他字符。
# crontab -e: 编辑当前用户的cron表；-l: 列出当前用户的cron作业；-r: 删除当前用户的cron表
```

## demo整理

demo1测试效果

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-03%2013.09.49.png)

即时性测试

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-03%2014.32.00.png)

将写死的路径，加入`read -p`读取功能，增强通用性。至于时间，我反倒觉得没必要写活，原因如下：

1. 看得懂的朋友会根据自己的需求调整修改
2. 这类“30 18 * * * 1”格式，就像“二进制”，不符合人的常规记忆。（做成字符串变量是最简单的做活了）
3. 自然语言转“30 18 * * * 1”这类特定格式，加入字典处理，条件千变万化的，反而还将简单的问题复杂化了

附源码：

```
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
printf "\n 最后，自定义的壁纸目录文件不要自行删除，造成脚本执行异常。 \n\n"

# 设置终端读取变量
read -p "1. 将自定义壁纸拖入到终端: " diy_wallpaper
printf "\n" 
read -p "2. 将系统壁纸拖入到终端: " sys_wallpaper
printf "\n" 

# 保持原样写代码
cat <<EOF > my_desktop_cron
# 周一傍晚六点半，自定义壁纸
30 18 * * 1 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$diy_wallpaper"'

# 周一至周四，晚上休息时间十一点十分，切换系统壁纸
10 23 * * 1-4 osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$sys_wallpaper"'

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
printf "\n 定时壁纸任务已完成。\n"

#----- 定时切换壁纸 -------------


# ------ 其他测试项 -------------

# 每隔三十天换一次壁纸，“x/30” 从x天之后的30天
# echo "0 0 */30 * * osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \
# \"~/Pictures/必应壁纸/KlostersSerneus-20230502.png\"'" \
# | crontab -

# ------ 其他测试项 -------------
```

测试效果

```
 bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-shell/mac_corn_diy_wallpaper.sh)"
```

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-03%2014.57.26.png)

这里分享下修改壁纸的玩具代码，只做个抛砖引玉，之后等等之类的功能增强，那就看各位了有心了。




