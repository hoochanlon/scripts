import paramiko
import time
import os
from datetime import datetime
import re

# 配置交换机的信息
hostname = "192.168.1.250"  # 交换机的IP地址
username = "yonghuming"  # SSH 登录用户名
password = "Mima12345@"  # SSH 登录密码

# 动态生成备份文件名，包含日期时间
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")  # 格式化时间
current_date = datetime.now().strftime("%Y%m%d")  # 当天日期
backup_filename = f"switch_backup_{timestamp}.cfg"  # 配置备份文件名

# 获取当前用户桌面路径
desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")
date_folder_path = os.path.join(desktop_path, current_date)  # 当天日期的文件夹路径
backup_filepath = os.path.join(date_folder_path, backup_filename)  # 文件完整路径

# 如果日期文件夹不存在，则创建
if not os.path.exists(date_folder_path):
    os.makedirs(date_folder_path)

# 创建 SSH 客户端
client = paramiko.SSHClient()

# 自动接受未知的主机密钥
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
    # 连接到交换机
    client.connect(hostname, username=username, password=password)
    # client.connect(hostname, username=username, password=password, port=2399)

    # 打开交互式 shell
    shell = client.invoke_shell()

    # 禁用分页
    shell.send("screen-length 0 temporary\n")
    time.sleep(1)

    # 执行备份命令
    shell.send("display current-configuration\n")
    time.sleep(2)  # 等待命令执行

    output = ""
    found_ops = False  # 初始化标志位，标记是否已找到 "ops"

    while True:
        # 增加接收缓冲区大小
        part = shell.recv(8848).decode('utf-8')

        # 将输出追加到结果中
        output += part

        # 判断是否遇到 "return"
        if 'return' in part:
            found_ops = True

        # 如果找到了 "ops"，继续读取直到出现 "return"
        if found_ops and 'return' in part:
            break  # 找到 "return"，停止读取

    # 先将原始输出写入文件
    with open(backup_filepath, "w") as backup_file:
        backup_file.write(output)

    # 重新读取文件内容，应用正则清理
    with open(backup_filepath, "r") as backup_file:
        raw_content = backup_file.read()

    # 使用正则删除 dis cu 以上所有信息，保证格式与 vrpcfg.cfg 等同
    cleaned_output = re.sub(
        r"(?s).*?display current-configuration\n", 
        "", 
        raw_content
    )

    # 将清理后的内容写回文件
    with open(backup_filepath, "w") as backup_file:
        backup_file.write(cleaned_output)

    print(f"备份已完成，配置已保存到 {backup_filepath}")

except Exception as e:
    print(f"连接或备份过程中发生错误: {e}")

finally:
    # 关闭 SSH 连接
    client.close()
