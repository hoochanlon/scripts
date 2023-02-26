echo -e "懒得搞什么美化，字体15大小左右，就差不多了，颜色设置成pro，“brew install fish”就行了。\n"

echo -e "一分钟考虑时间，倒计时：\c"

# 来自 [csdn-shell脚本倒计时](https://blog.csdn.net/Mrheiiow/article/details/121248427)
# 数字残留需要删除字符了。
t=60
while test $t -gt 0
do
    if [ $t -ge 10 ];then 
       echo -e "${t}\b\b\c"
    elif [ $t -eq 9 ];then
       echo -e "\b\c"
       echo -e "\b${t}\b\c"
    else
       echo -e "${t}\b\c"
    fi
    sleep 1
    t=$((t-1))
done


sleep 1

echo "将源文件备份为 ➡️ ./zshrc.bak"
cp -rfp ~/.zshrc ~/.zshrc.bak

#  "根据报错，安装需要依赖项"
brew install wget >/dev/null 2>&1
brew install python >/dev/null 2>&1
python3 -c "$(wget -q -O - https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py)"

# 懒得判断，直接抛异常
rm -rf ~/zshrc >/dev/null 2>&1

git clone https://github.com/Innei/zshrc.git

# 临时开代理测试
# export ALL_PROXY=socks5://127.0.0.1:7890

# 清除主题，/.local/bin 自启目录的antigen.zsh也删掉
# rm -rf ~/.config/iterm2 ~/.antigen ~/.local/bin/antigen.zsh /tmp/antigen.zsh


# 清除自启检查主题命令


cp -rfp ~/zshrc/.zshrc ~/.zshrc 
echo "测试效果"

# 参考
# [cnblogs-快速免费的公用 CDN —— jsDelivr ](https://www.cnblogs.com/lfri/p/12212878.html)
# [cnblogs-Linux实现脚本开机自启动](https://www.cnblogs.com/xingboy/p/15305027.html)