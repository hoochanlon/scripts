import paramiko
import time
import os
import csv

# 获取当前用户桌面路径
desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")

# 读取 CSV 文件并逐行处理
csv_file_path = os.path.join(desktop_path, "SSH登记表.csv")  # 假设 CSV 文件在桌面
# ftp_server_ip = "192.168.1.58"  # 本机的 FTP 服务 IP 地址
ftp_server_ip = "172.16.1.55" 
ftp_username = "admin"  # FTP 用户名
ftp_password = "123"  # FTP 密码

try:
    with open(csv_file_path, "r", encoding="utf-8") as csv_file:
        csv_reader = csv.reader(csv_file)
        
        for row in csv_reader:
            # 解析每一行数据
            if len(row) < 6:  # 如果行的列数不足，跳过
                print(f"跳过格式不正确的行: {row}")
                continue

            device_name, alias_name, hostname, username, password, port = row
            port = int(port)

            print(f"正在连接到 {hostname} ({device_name})，端口 {port}...")

            # FTP 文件名（初始为 alias_name）
            ftp_filename = f"{alias_name}_backup.zip"

            # 创建 SSH 客户端
            client = paramiko.SSHClient()
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            try:
                # 连接到交换机
                client.connect(hostname, port=port, username=username, password=password)

                # 打开交互式 shell
                shell = client.invoke_shell()
                time.sleep(1)

                # 启动 FTP 服务上传文件
                shell.send(f"ftp {ftp_server_ip}\n")
                time.sleep(2)
                shell.send(f"{ftp_username}\n")  # 输入 FTP 用户名
                time.sleep(1)
                shell.send(f"{ftp_password}\n")  # 输入 FTP 密码
                time.sleep(1)

                # 上传配置文件
                print(f"开始上传配置文件到 FTP 服务器，文件名: {ftp_filename}")
                shell.send("binary\n")  # 切换到二进制模式
                shell.send(f"put vrpcfg.zip {ftp_filename}\n")  # 上传文件
                time.sleep(5)  # 等待上传完成

                # 退出 FTP
                shell.send("quit\n")
                time.sleep(1)

                # 重命名为 device_name
                new_filename = f"{device_name}_backup.zip"
                local_path = os.path.join(desktop_path,"本机开启FTP交换机上传文件到此目录", ftp_filename) # 拼接 FTP服务器保存的指定目录
                renamed_path = os.path.join(desktop_path,"本机开启FTP交换机上传文件到此目录", new_filename)

                if os.path.exists(local_path):  # 如果文件存在，重命名为中文名
                    os.rename(local_path, renamed_path)
                    print(f"文件已重命名为: {renamed_path}")
                else:
                    print(f"文件上传后未找到: {local_path}")

            except Exception as e:
                print(f"处理设备 {device_name} ({hostname}) 时出错: {e}")

            finally:
                client.close()

except FileNotFoundError:
    print(f"CSV 文件未找到，请确认路径是否正确: {csv_file_path}")
except Exception as e:
    print(f"处理 CSV 文件时发生错误: {e}")
