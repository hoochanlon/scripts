# 保持代码样式写文件
cat <<'EOF' >~/Public/systeminfo.sh

# Mac颜色调试代码
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)

mindyou(){
    printf "\n"
    echo "${CYAN}请选择要获取的信息类型：${RESET}"
    printf "\n"
    echo "[1]. 获取关于计算机硬件的信息，如处理器、内存、硬盘、设备锁等。"
    echo "[2]. 获取有关网络连接和配置的信息，如网络接口、IP 地址、MAC 地址等。"
    echo "[3]. 获取有关操作系统版本及系统保护状态信息等，如操作系统版本、SIP状态等。"
    echo "[4]. 获取关于图形显示器和图形卡的信息，如显示器分辨率、图形卡型号等。"
    echo "[5]. 获取关于存储设备（磁盘驱动器）的信息，如驱动器容量、文件系统等。"
    echo "[6]. 获取关于连接到计算机上的 USB 设备的信息，如 USB 设备名称、厂商信息等。"
    echo "[7]. 获取关于电源（电池）状态和信息的信息，如电池剩余容量、充电状态等。"
    echo "[8]. 查看该说明说文本，或按[0]退出。"
}

clear
mindyou
echo ""

while true; do
    read -n 1 -s option

    clear

    case $option in
        1)
            echo "${YELLOW}开始获取计算机硬件信息... ${RESET}"
            system_profiler SPHardwareDataType
            echo "${GREEN}计算机硬件信息获取完成 ✅ ${RESET}"
            ;;
        2)
            echo "${YELLOW}开始获取计算机网络信息... ${RESET}"
            system_profiler SPNetworkDataType
            echo "${GREEN}网络连接和配置信息获取完成 ✅ ${RESET}"
            ;;
        3)
            echo "${YELLOW}开始获取有关操作系统版本及系统保护状态信息... ${RESET}"
            system_profiler SPSoftwareDataType
            echo "${GREEN}获取有关操作系统版本及系统保护状态信息已完成 ✅ ${RESET}"
            ;;
        4)
            echo "${YELLOW}开始获取图形显示器和图形卡信息... ${RESET}"
            system_profiler SPDisplaysDataType
            echo "${GREEN}图形显示器和图形卡信息获取完成 ✅ ${RESET}"
            ;;
        5)
            echo "${YELLOW}开始获取存储设备信息... ${RESET}"
            system_profiler SPStorageDataType
            echo "${GREEN}存储设备信息获取完成 ✅ ${RESET}"
            ;;
        6)
            echo "${YELLOW}开始获取USB设备信息... ${RESET}"
            system_profiler SPUSBDataType
            echo "${GREEN}USB设备信息获取完成 ✅ ${RESET}"
            ;;
        7)
            echo "${YELLOW}开始获取电源状态和信息... ${RESET}"
            system_profiler SPPowerDataType
            echo "${GREEN}电源状态和信息获取完成 ✅ ${RESET}"
            ;;
        8)
            mindyou
            ;;
        0)
            break
            ;;
        *)
            echo "${RED}无效的选项，请重新按对应数字键选择，按[8]查看说明，或按[0]退出。${RESET}"
            ;;
    esac

    echo ""
done

EOF

# 创建软链接文件夹
sudo -S mkdir -p /usr/local/bin
# 保险起见先删除再说
sudo rm -rf /usr/local/bin/systeminfo.shortcut
# 没有环境变量，进入目录创建软链接。
# cd /usr/local/bin

sudo ln -s  \
    ~/Public/systeminfo.sh /usr/local/bin/systeminfo.shortcut &&
    echo "alias systeminfo='bash systeminfo.shortcut'" >> ~/.zshrc

echo "现在可直接在终端使用 systeminfo ，调用“系统常用信息脚本”了。"
source ~/.zshrc # 重载.zshrc文件
exec zsh # 强制重新加载Zsh配置文件，替换当前终端会话



