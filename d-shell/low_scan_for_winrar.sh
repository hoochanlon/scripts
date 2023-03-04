

ymd_start="20230220"
ymd_end="20230223"
# 最新版是6.21，根据命名规则621
rar_v_num=621

while [ "$ymd_start" != "$ymd_end" ]
do

let ymd_start=`date -d "-1 days ago ${ymd_start}" +%Y%m%d`

# 网速不太好的情况下，可以选择超时15秒左右。请求返回头信息 http 200即ok
curl -I -m15 "https://www.win-rar.com/fileadmin/winrar-versions/sc/sc$ymd_start/rrlb/winrar-x64-"$rar_v_num"sc.exe" | head -n 1

# echo -e "\n $ymd_start ， $sc_num_start \n"

done

echo "https://www.win-rar.com/fileadmin/winrar-versions/sc/sc$ymd_start/rrlb/winrar-x64-"$rar_v_num"sc.exe"

# 调试代码
# curl -I -m2 "https://www.win-rar.com/fileadmin/winrar-versions/sc/sc20230223/rrlb/winrar-x64-621sc.exe" | head -n 1

# 参考 
# * [http状态码204/206/200/302/303/307](https://blog.csdn.net/weixin_33795743/article/details/85895683)
# * [40 个很有用的 Mac OS X Shell 脚本和终端命令](http://www.51sio2.cn/article/3881429388.html)
# * [moonapi 月萌软件开发工作室-php Python–遍历一系列日期](https://www.moonapi.com/news/6385.html)
# * [jb51.net-linux shell中实现循环日期的实例代码](https://www.jb51.net/article/147355.htm)

# 筛选用
# * [菜鸟站长之家-WinRAR 5.61免费商业正版破解无广告(含注册码)](https://www.cnzzzj.com/5663.html)
# * [WinRAR简体中文32/64位商业版下载（2023/02/23已更新至WinRAR6.21）](http://www.kaixinit.com/info/soft/1712.html)