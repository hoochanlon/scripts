# screen_watermark_tkinter.py
import tkinter, win32api, win32con, pywintypes, os
import socket
import getpass
import tkinter.font as tkFont
import platform

'''
作者：hoochanlon
主页：https://github.com/hoochanlon
'''

# 获取计算机名
hostname = socket.gethostname()
# 获取IP
Compute_addr = socket.gethostbyname(hostname)   # get ip
print(Compute_addr)

# 获取登陆用户名
userName = getpass.getuser()

show = '屏幕加水印-{}-{}-{}'.format(hostname, userName, Compute_addr)


# 设置窗口透明度等
def setup_window(root_window):
    root_window.overrideredirect(True)  # 隐藏显示框True
    root_window.attributes("-alpha", 0.4)  # 窗口透明度40% 
    w = root_window.winfo_screenwidth()
    h = root_window.winfo_screenheight()
    root_window.geometry("%dx%d" % (w, h))
    root_window.lift()  # 置顶层
    root_window.wm_attributes("-topmost", True)  # 始终置顶层
    root_window.wm_attributes("-disabled", True)
    root_window.wm_attributes("-transparentcolor", "white")  # 白色背景透明
    hWindow = pywintypes.HANDLE(int(root_window.frame(), 16))  # 16
    exStyle = win32con.WS_EX_COMPOSITED | win32con.WS_EX_LAYERED | win32con.WS_EX_NOACTIVATE | win32con.WS_EX_TOPMOST | win32con.WS_EX_TRANSPARENT
    win32api.SetWindowLong(hWindow, win32con.GWL_EXSTYLE, exStyle)


def create_watermark_windows():
    # 创建并设置窗口
    windows = [tkinter.Tk() for _ in range(12)]  # 创建 12 个窗口

    # 设置每个窗口
    for window in windows:
        setup_window(window)

    # 设置水印标签
    tkinter.Label(windows[0], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw').pack()  # 左上
    tkinter.Label(windows[1], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw').pack()  # 左下
    tkinter.Label(windows[3], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='center').pack()  # 中间
    tkinter.Label(windows[4], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne').pack()  # 右上
    tkinter.Label(windows[5], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se').pack()  # 右下

    # 新增位置的水印
    tkinter.Label(windows[6], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw', pady=50).pack()  # 左上
    tkinter.Label(windows[7], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw', pady=50).pack()  # 左下
    tkinter.Label(windows[8], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='e').pack()  # 右中
    tkinter.Label(windows[9], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='w').pack()  # 左中
    tkinter.Label(windows[10], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne', pady=50).pack()  # 右上
    tkinter.Label(windows[11], text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se', pady=50).pack()  # 右下

    return windows


if __name__ == '__main__':
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")
    else:
        windows = create_watermark_windows()
        for window in windows:
            window.mainloop()  # 循环显示每个窗口

