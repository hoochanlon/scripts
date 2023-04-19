# 实验
## brew install p7zip > /dev/null 2>&1 运行效率较低，大概有2～3秒不等，if算了
## 在Mac上，7z并不支持验证rar压缩包密码；Mac下面的rar，也不支持zip的密码验证。
## 网上txt为CRLF的问题，dos2unix搞定。
## 密码没找到，没输出，排查问题如下：
### $0 用于存储上一个命令的退出状态。当一个命令成功执行时，它的退出状态为 0，否则为非零值。
### 直接不在外层初始化flag，容易算数异常，推测是作用域问题。

# 缺什么就安装什么
[ ! -e $(which rar) ] && brew install rar
[ ! -e $(which 7z) ] && brew install p7zip
[ ! -e $(which dos2unix) ] && brew install dos2unix

# 不存在就下载密码本
if [ ! -f ~/Downloads/rarpasswd.txt ]; then
    curl -o ~/Downloads/rarpasswd.txt https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-txt/rarpasswd.txt
fi

# 保存密码本为基本路径格式
# 无法输出用户名 // ，储存变量结果后，再输出 /Users/<用户名> 正常。
username=$USER
passwd_txt="/Users/$username/Downloads/rarpasswd.txt"
# CRLF文本换成LF文本
dos2unix $passwd_txt >/dev/null 2>&1

# has_passwd_rar="/Users/chanlonhoo/Desktop/BlackFell.zip"
echo -e "\n"
read -p "将压缩包文件拖入到终端: " has_passwd_rar

# 打上flag，保存break状态码，固化存储。
found_passwd_tag_num=0

unrar_passwd_find() {
    # 遍历密码文件中的每一行密码
    while read password; do
        # 尝试使用当前密码解压缩压缩包
        unrar t -p$password "$has_passwd_rar" >/dev/null 2>&1

        # 检查解压缩命令的退出码
        if [ $? -eq 0 ]; then
            # 如果退出码为 0，说明密码正确，输出提示信息并退出循环
            echo -e "\n密码是: $password \n"
            # flag
            found_passwd_tag_num=1
            break
        fi
    done <$passwd_txt
    # echo "$?"

    if [ $found_passwd_tag_num -ne 1 ]; then
        echo -e "\n没找到正确的密码。\n"
    fi

}

7z_passwd_find() {
    # 遍历密码文件中的每一行密码
    while read password; do
        # 尝试使用当前密码解压缩压缩包
        7z t -p$password "$has_passwd_rar" >/dev/null 2>&1

        # 检查解压缩命令的退出码
        if [ $? -eq 0 ]; then
            # 如果退出码为 0，说明密码正确，输出提示信息并退出循环
            echo -e "\n密码是: $password \n"
            # flag
            found_passwd_tag_num=1
            break
        fi
    done <"$passwd_txt"

    if [ $found_passwd_tag_num -ne 1 ]; then
        echo -e "\n没找到正确的密码。\n"
    fi

}

# 判断文件名后缀是否包含rar
if [[ ${has_passwd_rar##*.} == "rar" ]]; then
    unrar_passwd_find
else
    7z_passwd_find
fi
