import paramiko
import time
import os
import csv
from datetime import datetime
import re

# 获取当前用户桌面路径
desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")

# 动态生成当天日期的文件夹
current_date = datetime.now().strftime("%Y%m%d")  # 当天日期
date_folder_path = os.path.join(desktop_path, current_date)  # 日期文件夹路径

# 如果日期文件夹不存在，则创建
if not os.path.exists(date_folder_path):
    os.makedirs(date_folder_path)

# 读取 CSV 文件并逐行处理
csv_file_path = os.path.join(desktop_path, "SSH登记表.csv")  # 假设 CSV 文件在桌面
try:
    with open(csv_file_path, "r", encoding="utf-8") as csv_file:
        csv_reader = csv.reader(csv_file)
        
        for row in csv_reader:
            # 解析每一行数据
            if len(row) < 6:
                print(f"跳过格式不正确的行: {row}")
                continue

            device_name, alias_name, hostname, username, password, port = row
            port = int(port)  # 将端口号转换为整数
            backup_filename = f"{device_name}.txt"  # 备份文件名
            backup_filepath = os.path.join(date_folder_path, backup_filename)  # 文件完整路径

            # 创建 SSH 客户端
            client = paramiko.SSHClient()

            # 自动接受未知的主机密钥
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            try:
                # 连接到交换机，使用动态端口
                print(f"正在连接到 {hostname} ({device_name})，端口 {port}...")
                client.connect(hostname, username=username, password=password, port=port)

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
                with open(backup_filepath, "w", encoding="utf-8") as backup_file:
                    backup_file.write(output)

                # 重新读取文件内容，应用正则清理
                with open(backup_filepath, "r", encoding="utf-8") as backup_file:
                    raw_content = backup_file.read()

                # 使用正则删除 dis cu 以上所有信息，保证格式与 vrpcfg.cfg 等同
                cleaned_output = re.sub(
                    r"(?s).*?display current-configuration\n", 
                    "", 
                    raw_content
                )

                # 将清理后的内容写回文件
                with open(backup_filepath, "w", encoding="utf-8") as backup_file:
                    backup_file.write(cleaned_output)

                print(f"{device_name} ({hostname}) 备份完成，保存到 {backup_filepath}")

            except Exception as e:
                print(f"备份 {device_name} ({hostname}) 失败: {e}")

            finally:
                # 关闭 SSH 连接
                client.close()

except FileNotFoundError:
    print(f"CSV 文件未找到，请确认路径是否正确: {csv_file_path}")
except Exception as e:
    print(f"处理 CSV 文件时发生错误: {e}")
