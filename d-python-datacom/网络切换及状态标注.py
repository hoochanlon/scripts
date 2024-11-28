import subprocess 
import os
import time
from PIL import Image, ImageDraw
import pystray
from pystray import MenuItem as item
import threading
from tkinter import Tk, Label, Entry, Button, messagebox

# 定义接口名称
interface = "以太网"

# 固定静态 IP 配置（写死的 IP、子网掩码、网关和 DNS）
static_ip = "172.16.1.55"
static_mask = "255.255.255.0"
static_gateway = "172.16.1.254"
static_dns1 = "172.16.1.1"
static_dns2 = "114.114.114.114"

# 创建透明背景的圆形图标
def create_icon(color):
    size = (64, 64)
    image = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    if color == 'green':
        fill_color = (0, 255, 0, 255)
    elif color == 'yellow':
        fill_color = (255, 255, 0, 255)
    elif color == 'pink':
        fill_color = (255, 105, 180, 255)  # 粉色
    else:
        fill_color = (128, 128, 128, 255)  # 默认灰色

    draw.ellipse([0, 0, size[0], size[1]], fill=fill_color)
    return image

# 检查网络是否启用 DHCP
def check_dhcp():
    temp_file = os.path.join(os.getenv('TEMP'), 'display_dhcp_status_output.txt')
    subprocess.run(f'netsh interface ip show config name={interface} > "{temp_file}"', shell=True)
    dhcp_status = None
    with open(temp_file, 'r', encoding='gbk') as file:
        for line in file:
            if "DHCP 已启用" in line:
                dhcp_status = line.split(":")[1].strip()
    os.remove(temp_file)
    return dhcp_status

# 获取当前的 IP 配置
def get_current_ip_config():
    command = f'netsh interface ip show config name="{interface}"'
    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='gbk')
    output = result.stdout

    ip, mask, gateway, dns1, dns2 = None, None, None, None, None

    for line in output.splitlines():
        if "IP 地址" in line and not ip:
            ip = line.split(":")[1].strip()  # 去掉前后空格
        if "子网掩码" in line and not mask:
            mask = line.split(":")[1].strip()  # 去掉前后空格
        if "默认网关" in line and not gateway:
            gateway = line.split(":")[1].strip()  # 去掉前后空格
        if "DNS 服务器" in line:
            if not dns1:
                dns1 = line.split(":")[1].strip()  # 去掉前后空格
            elif not dns2:
                dns2 = line.strip()

    return ip, mask, gateway, dns1, dns2

# 更新托盘图标状态
def update_icon(icon):
    dhcp_status = check_dhcp()
    ip, mask, gateway, dns1, dns2 = get_current_ip_config()

    # 判断是否为 DHCP
    if dhcp_status == "是":
        icon.icon = create_icon('green')  # DHCP -> 绿色
    # 判断是否为固定静态 IP
    elif (ip == "172.16.1.55"):
        icon.icon = create_icon('yellow')  # 固定静态 IP -> 黄色
    # 否则为自定义静态 IP
    else:
        icon.icon = create_icon('pink')  # 自定义静态 IP -> 粉色

# 切换到 DHCP
def switch_to_dhcp(icon, item):
    subprocess.run(f'netsh interface ip set address name={interface} source=dhcp', shell=True)
    subprocess.run(f'netsh interface ip set dns name={interface} source=dhcp', shell=True)
    update_icon(icon)

# 切换到固定静态 IP
def switch_to_fixed_static(icon, item):
    subprocess.run(f'netsh interface ip set address name={interface} source=static addr={static_ip} mask={static_mask} gateway={static_gateway}', shell=True)
    subprocess.run(f'netsh interface ip set dns name={interface} source=static addr={static_dns1}', shell=True)
    subprocess.run(f'netsh interface ip add dns name={interface} addr={static_dns2} index=2', shell=True)
    update_icon(icon)

# 切换到自定义静态 IP
def switch_to_custom_static(icon, item):
    def input_window():
        def submit():
            diy_ip = entry_ip.get().strip()
            diy_mask = entry_mask.get().strip()
            diy_gateway = entry_gateway.get().strip()
            diy_dns1 = entry_dns1.get().strip()
            diy_dns2 = entry_dns2.get().strip()

            if diy_ip and diy_mask and diy_gateway and diy_dns1:
                subprocess.run(f'netsh interface ip set address name={interface} source=static addr={diy_ip} mask={diy_mask} gateway={diy_gateway}', shell=True)
                subprocess.run(f'netsh interface ip set dns name={interface} source=static addr={diy_dns1}', shell=True)
                if diy_dns2:
                    subprocess.run(f'netsh interface ip add dns name={interface} addr={diy_dns2} index=2', shell=True)
                update_icon(icon)
                root.destroy()
            else:
                messagebox.showerror("错误", "请填写完整的必填项！")

        root = Tk()
        root.title("输入自定义静态 IP 配置")
        root.geometry("400x250")
        root.resizable(False, False)

        Label(root, text="IP 地址：").grid(row=0, column=0, padx=10, pady=5, sticky='e')
        Label(root, text="子网掩码：").grid(row=1, column=0, padx=10, pady=5, sticky='e')
        Label(root, text="网关地址：").grid(row=2, column=0, padx=10, pady=5, sticky='e')
        Label(root, text="首选 DNS：").grid(row=3, column=0, padx=10, pady=5, sticky='e')
        Label(root, text="备用 DNS (可选)：").grid(row=4, column=0, padx=10, pady=5, sticky='e')

        entry_ip = Entry(root, width=30)
        entry_mask = Entry(root, width=30)
        entry_gateway = Entry(root, width=30)
        entry_dns1 = Entry(root, width=30)
        entry_dns2 = Entry(root, width=30)

        entry_ip.grid(row=0, column=1, padx=10, pady=5)
        entry_mask.grid(row=1, column=1, padx=10, pady=5)
        entry_gateway.grid(row=2, column=1, padx=10, pady=5)
        entry_dns1.grid(row=3, column=1, padx=10, pady=5)
        entry_dns2.grid(row=4, column=1, padx=10, pady=5)

        Button(root, text="提交", command=submit).grid(row=5, column=0, columnspan=2, pady=10)
        root.mainloop()

    threading.Thread(target=input_window, daemon=True).start()

# 创建任务栏图标
def on_quit(icon, item):
    icon.stop()

def create_tray_icon():
    icon = pystray.Icon("network_status")
    icon.icon = create_icon('gray')

    # 创建托盘菜单
    icon.menu = pystray.Menu(
        item('切换到 DHCP', lambda icon, item: switch_to_dhcp(icon, item)),
        item('切换到固定静态 IP', lambda icon, item: switch_to_fixed_static(icon, item)),
        item('切换到自定义静态 IP', lambda icon, item: switch_to_custom_static(icon, item)),
        item('退出', on_quit)
    )

    update_icon(icon)

    # 定时更新图标状态
    def periodic_update():
        while True:
            update_icon(icon)
            time.sleep(5)

    threading.Thread(target=periodic_update, daemon=True).start()

    icon.run()

if __name__ == "__main__":
     create_tray_icon()