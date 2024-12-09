import sys
import socket
import getpass
import os
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont
import hostname_user_ip_date

'''
作者：hoochanlon
主页：https://github.com/hoochanlon
'''

# 设置 Qt 平台插件路径
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# 获取计算机名、用户名
hostname, username = hostname_user_ip_date.get_hostname_username()

# 获取IP
compute_addr = hostname_user_ip_date.get_preferred_ip()

# 获取时间
current_date =  hostname_user_ip_date.get_current_date()


# show = f'屏幕加水印-{hostname}-{username}-{current_date}-{compute_addr}'
show = f'屏幕加水印-{hostname}-{username}-{compute_addr}'

# 自定义窗口类，用于水印显示
class WatermarkWindow(QWidget):
    def __init__(self, position, pady=100, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # 透明度40%

        # 获取屏幕宽高
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # 设置窗口为全屏

        # 创建水印标签
        self.label = QLabel(self)
        self.label.setText(show)
        self.label.setFont(QFont('微软雅黑', 23))
        self.label.setStyleSheet('color: #708090;')

        # 使用布局设置标签位置
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)  # 去除布局边距

        # 设置水印位置
        if position == 'nw':  # 左上角
            layout.setAlignment(Qt.AlignTop | Qt.AlignLeft)  # 水印左上对齐
            # layout.setContentsMargins(padx, 100, 0, 0)  # 控制左上边距 pady 100
            layout.setContentsMargins(padx, pady, 0, 0)  # 控制左上边距
        elif position == 'sw':  # 左下角
            layout.setAlignment(Qt.AlignBottom | Qt.AlignLeft)  # 水印左下对齐
            # layout.setContentsMargins(padx, 0, 0, 100)  # 控制左下边距 pady 100
            layout.setContentsMargins(padx, 0, 0, pady)  # 控制左下边距
        elif position == 'ne':  # 右上角
            layout.setAlignment(Qt.AlignTop | Qt.AlignRight)  # 水印右上对齐
            # layout.setContentsMargins(0, 100, padx, 0)  # 控制右上边距
            layout.setContentsMargins(0, pady, padx, 0)  # 控制右上边距
        elif position == 'se':  # 右下角
            layout.setAlignment(Qt.AlignBottom | Qt.AlignRight)  # 水印右下对齐
            # layout.setContentsMargins(0, 0, padx, 100)  # 控制右下边距 pady 100
            layout.setContentsMargins(0, 0, padx, 100)  # 控制右下边距 
        elif position == 'center':  # 屏幕中心
            layout.setAlignment(Qt.AlignCenter)  # 水印居中对齐
        elif position == 'e':  # 右中
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignRight)  # 水印垂直居中，右对齐
        elif position == 'w':  # 左中
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignLeft)  # 水印垂直居中，左对齐

        layout.addWidget(self.label)  # 添加标签到布局

    def paintEvent(self, event):
        # 不需要手动绘制背景或文本，使用布局和对齐来自动处理
        pass


def create_windows():
    windows = []
    positions = [
        'nw', 'sw', 'center', 'ne', 'se',  # 四个角和中心位置
        'nw', 'sw',  # 重复左上角和左下角水印（可以添加多个水印）
        'e', 'w',    # 水印添加到右中和左中
        'ne', 'se'   # 重复右上角和右下角水印
    ]  # 水印位置列表

    # 创建每个窗口，并指定对应的边距和位置
    for position in positions:
        # if position == 'sw':  # 如果是左下角
        #     pady = 100  # 设置左下角水印的垂直偏移量（增加高度）
        window = WatermarkWindow(position)  # 创建水印窗口
        window.show()  # 显示水印窗口
        windows.append(window)  # 将窗口添加到列表

    # 添加第二个左下角水印
    sw2_window = WatermarkWindow('sw', pady=200)  # 创建另一个左下角水印，设置不同的pady值
    sw2_window.show()  # 显示第二个左下角水印
    windows.append(sw2_window)  # 添加到窗口列表
    
    return windows


if __name__ == '__main__':
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")  # 如果文件存在，不显示水印
    else:
        app = QApplication(sys.argv)
        windows = create_windows()  # 创建水印窗口
        sys.exit(app.exec_())  # 启动应用程序
