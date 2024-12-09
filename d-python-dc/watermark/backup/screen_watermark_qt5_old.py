# screen_watermark_qt5_old.py
import sys
import socket
import getpass
import os
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

'''
作者：hoochanlon
主页：https://github.com/hoochanlon
'''

# 设置 Qt 平台插件路径
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# 获取计算机名
hostname = socket.gethostname()
# 获取IP
Compute_addr = socket.gethostbyname(hostname)
# 获取登录用户名
userName = getpass.getuser()

show = f'屏幕加水印-{hostname}-{userName}-{Compute_addr}'

# 自定义窗口类，用于水印显示
class WatermarkWindow(QWidget):
    def __init__(self, position, parent=None):
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

        if position == 'nw':
            layout.setAlignment(Qt.AlignTop | Qt.AlignLeft)  # 左上
        elif position == 'sw':
            layout.setAlignment(Qt.AlignBottom | Qt.AlignLeft)  # 左下
        elif position == 'ne':
            layout.setAlignment(Qt.AlignTop | Qt.AlignRight)  # 右上
        elif position == 'se':
            layout.setAlignment(Qt.AlignBottom | Qt.AlignRight)  # 右下
        elif position == 'center':
            layout.setAlignment(Qt.AlignCenter)  # 中间
        elif position == 'e':
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignRight)  # 右中
        elif position == 'w':
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignLeft)  # 左中

        layout.addWidget(self.label)  # 添加标签到布局

    def paintEvent(self, event):
        # 不需要手动绘制背景或文本，使用布局和对齐来自动处理
        pass


def create_windows():
    windows = []
    positions = ['nw', 'sw', 'center', 'ne', 'se', 'nw', 'sw', 'e', 'w', 'ne', 'se']
    for position in positions:
        window = WatermarkWindow(position)
        window.show()
        windows.append(window)
    return windows


if __name__ == '__main__':
    # 检查文件是否存在
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("不显示")
    else:
        app = QApplication(sys.argv)
        windows = create_windows()
        sys.exit(app.exec_())  # 启动应用程序
