import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter, QFont
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
current_date = hostname_user_ip_date.get_current_date()

# 定义显示的水印文本
show = f'屏幕加水印-{hostname}-{username}-{current_date}-{compute_addr}'


class WatermarkWindow(QWidget):
    def __init__(self, position, pady=0, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # 透明度40%

        # 获取屏幕宽高
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # 设置窗口为全屏
        self.position = position
        self.pady = pady
        self.padx = padx

    def paintEvent(self, event):
        """自定义绘制水印文本，使用45度倾斜"""
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)  # 设置抗锯齿渲染
        painter.setFont(QFont("微软雅黑", 23))  # 设置字体和大小

        # 保存当前状态
        painter.save()

        # 获取当前窗口宽高
        w = self.width()
        h = self.height()

        # 根据位置调整文本渲染偏移量
        if self.position == 'nw':
            watermark_text = f'左上角-{show}'  # 添加方向标记
            painter.translate(self.padx, self.pady)  # 左上角偏移
        elif self.position == 'sw':
            watermark_text = f'左下角-{show}'  # 添加方向标记
            painter.translate(self.padx, h - self.pady)  # 左下角偏移
        elif self.position == 'ne':
            watermark_text = f'右上角-{show}'  # 添加方向标记
            painter.translate(w - self.padx, self.pady)  # 右上角偏移
        elif self.position == 'se':
            watermark_text = f'右下角-{show}'  # 添加方向标记
            painter.translate(w - self.padx, h - self.pady)  # 右下角偏移
        elif self.position == 'center':
            watermark_text = f'中心-{show}'  # 添加方向标记
            painter.translate(w / 2 + self.padx, h / 2 + self.pady)  # 中心位置偏移
        elif self.position == 'e':
            watermark_text = f'右中-{show}'  # 添加方向标记
            painter.translate(w - self.padx - 50, h / 2 + self.pady)  # 调整偏移，确保水印可见
        elif self.position == 'w':
            watermark_text = f'左中-{show}'  # 添加方向标记
            painter.translate(self.padx + 50, h / 2 + self.pady)  # 调整偏移，确保水印可见

        # 这里添加新的右下角水印
        elif self.position == 'right_bottom':
            watermark_text = f'右下角新水印-{show}'  # 添加方向标记
            painter.translate(w - self.padx, h - self.pady)  # 右下角偏移

        painter.rotate(-45)  # 设置倾斜角度
        painter.setPen(Qt.gray)

        # 绘制水印文本
        painter.drawText(0, 0, watermark_text)  # 使用更新后的水印文本
        painter.restore()


def create_windows():
    windows = []

    # 定义每个位置的偏移量
    positions = [
        ('nw', 50, 50),  # 左上角，偏移量 (pady, padx)
        ('sw', 100, 50),  # 左下角，偏移量 (pady, padx)
        ('ne', 50, 150),  # 右上角，偏移量 (pady, padx)
        ('se', 100, 150),  # 右下角，偏移量 (pady, padx)
        ('center', 150, 0),  # 中心，偏移量 (pady, padx)
        ('w', 0, 0),     # 左中，偏移到下方 (pady, padx)
        ('e', 100, 400),    # 右中，偏移到上方 (pady, padx)
        ('right_bottom', 100, 100)  # 新增的右下角水印，偏移量 (pady, padx)
    ]

    for position, pady, padx in positions:
        window = WatermarkWindow(position, pady=pady, padx=padx)
        window.show()
        windows.append(window)

    return windows


if __name__ == '__main__':
    app = QApplication(sys.argv)
    windows = create_windows()
    sys.exit(app.exec_())
