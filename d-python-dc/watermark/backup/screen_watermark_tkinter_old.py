# screen_watermark_tkinter_old.py
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


# 创建其他四个窗口
root1 = tkinter.Tk()
root2 = tkinter.Tk()
root3 = tkinter.Tk()
root4 = tkinter.Tk()
root5 = tkinter.Tk()  # 新增的窗口
root6 = tkinter.Tk()  # 新增的窗口
root7 = tkinter.Tk()  # 新增的窗口
root8 = tkinter.Tk()  # 新增的窗口
root9 = tkinter.Tk()  # 新增的窗口
root10 = tkinter.Tk()  # 新增的窗口
root11 = tkinter.Tk()  # 新增的窗口

# 设置每个窗口
setup_window(root1)
setup_window(root2)
setup_window(root3)
setup_window(root4)
setup_window(root5)  # 配置新窗口
setup_window(root6)  # 配置新窗口
setup_window(root7)  # 配置新窗口
setup_window(root8)  # 配置新窗口
setup_window(root9)  # 配置新窗口
setup_window(root10)  # 配置新窗口
setup_window(root11)  # 配置新窗口



# 设置水印标签
tkinter.Label(root1, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw').pack()  # 左上
tkinter.Label(root2, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw').pack()  # 左下
tkinter.Label(root3, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='center').pack()  # 中间
tkinter.Label(root4, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne').pack()  # 右上
tkinter.Label(root5, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se').pack()  # 右下



# 新增位置的水印
tkinter.Label(root6, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw', pady=50).pack()  # 左上
tkinter.Label(root7, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw', pady=50).pack()  # 左下
tkinter.Label(root8, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='e').pack()  # 右中
tkinter.Label(root9, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='w').pack()  # 右中
tkinter.Label(root10, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne', pady=50).pack()  # 右上
tkinter.Label(root11, text=show, font=('微软雅黑', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se', pady=50).pack()  # 右下



Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
exists = os.path.exists(current_dir)

if exists:
    print("不显示")
else:
    root1.mainloop()  # 循环
    root1.mainloop()  # 循环
    root2.mainloop()  # 循环
    root3.mainloop()  # 循环
    root4.mainloop()  # 循环
    root5.mainloop()  # 循环
    root6.mainloop()  # 循环
    root7.mainloop()  # 循环
    root8.mainloop()  # 循环
    root9.mainloop()  # 循环
    root10.mainloop()  # 循环
    root11.mainloop()  # 循环

