import os
import sys
import screen_watermark_tkinter
import screen_watermark_qt5
import screen_watermark_qt5_oblique



def qt5_effect():
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")  # 如果文件存在，不显示水印
    else:
        app = screen_watermark_qt5.QApplication(sys.argv)
        windows = screen_watermark_qt5.create_windows()  # 创建水印窗口
        sys.exit(app.exec_())  # 启动应用程序

def tkinter_effect():
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")
    else:
        windows = screen_watermark_tkinter.create_watermark_windows()
        for window in windows:
            window.mainloop()  # 循环显示每个窗口

def qt5_oblique_effect():
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")  # 如果文件存在，不显示水印
    else:
        app = screen_watermark_qt5_oblique.QApplication(sys.argv)
        windows = screen_watermark_qt5_oblique.create_windows()  # 创建水印窗口
        sys.exit(app.exec_())  # 启动应用程序


if __name__ == '__main__':
    qt5_effect()  # 查看 qt5 实现效果
    # tkinter_effect() # 查看 tkinter 实现效果
    # qt5_oblique_effect() # 查看 qt5_oblique 实现效果