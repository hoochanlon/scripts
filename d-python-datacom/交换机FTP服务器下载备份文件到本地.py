import ftplib
import os
import csv

# === 全局配置 ===
CSV_FILE = "C:/Users/administrator/Desktop/交换机清单.csv"              # CSV 文件路径
LOCAL_DIR = "C:/Users/administrator/Desktop/交换机文件备份"             # 本地保存路径
REMOTE_FILE_PATH = "/vrpcfg.zip"          # 统一的远程文件路径

def download_from_ftp(name, ip, port, username, password):
    local_file_path = os.path.join(LOCAL_DIR, f"{name}.zip")

    try:
        # 连接 FTP
        ftp = ftplib.FTP()
        ftp.connect(ip, int(port))
        ftp.login(username, password)
        print(f"[+] 成功连接至 {name} ({ip})")

        # 进入远程目录（如有）
        remote_dir = os.path.dirname(REMOTE_FILE_PATH)
        if remote_dir and remote_dir != "/":
            ftp.cwd(remote_dir)
            print(f"    切换目录到: {remote_dir}")

        # 创建本地目录
        os.makedirs(LOCAL_DIR, exist_ok=True)

        # 下载并重命名
        with open(local_file_path, "wb") as f:
            ftp.retrbinary(f"RETR {os.path.basename(REMOTE_FILE_PATH)}", f.write)
        print(f"[✓] 下载完成: {local_file_path}")

        ftp.quit()
    except ftplib.all_errors as e:
        print(f"[!] {name} ({ip}) 下载失败: {e}")

def main():
    if not os.path.exists(CSV_FILE):
        print(f"[!] 找不到CSV文件: {CSV_FILE}")
        return

    with open(CSV_FILE, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            name = row["name"]
            ip = row["ip"]
            port = row["port"]
            username = row["username"]
            password = row["password"]
            print(f"\n[•] 开始处理: {name} ({ip})")
            download_from_ftp(name, ip, port, username, password)

if __name__ == "__main__":
    main()
