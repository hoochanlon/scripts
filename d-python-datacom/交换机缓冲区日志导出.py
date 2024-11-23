import paramiko
import time
import os
from datetime import datetime
import re
from colorama import Fore, Back, Style
from wasabi import msg

# 配置交换机的信息
hostname = "192.168.1.3"  # 交换机的IP地址
username = "yonghuming"  # SSH 登录用户名
password = "Mima12345@"  # SSH 登录密码
port = 2399  # 端口号

# 动态生成备份文件名，包含日期时间
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")  # 格式化时间
current_date = datetime.now().strftime("%Y%m%d")  # 当天日期
backup_filename = f"switch_log_backup_{timestamp}.txt"  # 配置备份文件名

# 获取当前用户桌面路径
desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")
date_folder_path = os.path.join(desktop_path, current_date)  # 当天日期的文件夹路径
backup_filepath = os.path.join(date_folder_path, backup_filename)  # 文件完整路径

# 如果日期文件夹不存在，则创建
os.makedirs(date_folder_path, exist_ok=True)

# 记录开始时间
start_time = time.time()
now_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
print(Fore.YELLOW + "当前时间为："+ now_time)
msg.warn("警告：输出缓冲区所有日志信息，预计操作时间大约 15 分钟左右。")


# 创建 SSH 客户端
client = paramiko.SSHClient()

# 自动接受未知的主机密钥
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
    # 连接到交换机
    client.connect(hostname, username=username, password=password, port=port)

    # 打开交互式 shell
    shell = client.invoke_shell()

    # 禁用分页（根据交换机品牌和型号，命令可能不同）
    shell.send("screen-length 0 temporary\n")  # Huawei 设备
    # time.sleep(2)

    # 执行显示 logbuffer 命令
    shell.send("display logbuffer\n")
    # time.sleep(3)  # 等待命令执行

    output = ""
    collecting = True  # 标记是否在收集数据

    # 设置缓冲区大小，100kb左右
    buffer_size = 100100  # 缓冲区大小，适当调整
    

    # 记录上一次读取的部分，用于判断是否继续
    last_part = ""
    
    while collecting:
        part = shell.recv(buffer_size).decode('utf-8')  # 每次读取更大的字节数
        output += part  # 将读取到的内容追加到输出中

        # 如果没有新数据，判断是否结束
        if len(part) == 0 or part == last_part:
            # 可以使用短时间的延时（减少不必要的停顿）
            time.sleep(0.2)  # 稍微减少等待时间，避免不必要的长时间停顿
            if len(part) == 0:  # 如果没有新数据，认为输出结束
                collecting = False
        
        last_part = part  # 更新上次读取的部分

    # 先将原始输出写入文件
    with open(backup_filepath, "w") as backup_file:
        backup_file.write(output)

    # 重新读取文件内容，应用正则清理
    with open(backup_filepath, "r") as backup_file:
        raw_content = backup_file.read()

    # 使用正则删除 display logbuffer 之前的所有信息
    cleaned_output = re.sub(
        r"(?s).*?display logbuffer\n", 
        "", 
        raw_content
    )

    # 将清理后的内容写回文件
    with open(backup_filepath, "w") as backup_file:
        backup_file.write(cleaned_output)

    print(f"备份已完成，配置已保存到 {backup_filepath}")

except paramiko.AuthenticationException:
    print("SSH 认证失败，请检查用户名和密码.")
except paramiko.SSHException as e:
    print(f"SSH 连接或执行过程中发生错误: {e}")
except Exception as e:
    print(f"发生错误: {e}")

finally:
    # 记录结束时间并计算执行时间
    end_time = time.time()
    elapsed_time = end_time - start_time  # 计算耗时
    
    minutes = int(elapsed_time // 60)  # 计算分钟
    seconds = int(elapsed_time % 60)  # 计算秒钟
    now_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(Fore.YELLOW + f"代码操作完成，当前时间：{now_time}，总耗时: {minutes} 分 {seconds} 秒")

    # 关闭 SSH 连接
    client.close()
