# 屏幕添加水印

由于 tkinter 实现桌面水印字体有较明显的锯齿感，因此采用 Qt5 重写了一遍，也保留了之前旧的实现方式。

1. 程序通过创建了多个全屏透明窗口，大小和屏幕一致。去掉了窗口的边框和标题栏，使窗口看起来没有边框。
2. 窗口的内容半透明，看起来不会遮挡其他程序，将窗口的背景色设置为白色，之后这一部分会变成透明。
3. 控制文本相对于窗口的位置，也就是水印位置，并将窗口设置为始终在所有窗口之上显示，这样水印不会被其他程序窗口覆盖。
4. 透明化使得这个透明窗口不会接收用户的点击或交互，只是一个纯粹的视觉元素，通过相关参数设置保证水印不会干扰用户的操作。

## 效果展示

tkinter实现效果

![ ](https://img.yonrd.com/i/2024/12/08/sxhfvs.png)

qt5实现效果

![ ](https://img.yonrd.com/i/2024/12/08/sxhezz.png)

![ ](https://img.yonrd.com/i/2024/12/09/nccwjv.png)

## 使用方式

生成环境依赖，并安装环境依赖

```
pip freeze > requirements.txt
pip install -r requirements.txt
```

`python main.py` 查看相关效果

```
if __name__ == '__main__':
    qt5_effect()  # 查看 qt5 实现效果
    # tkinter_effect() # 查看 tkinter 实现效果
    # qt5_oblique_effect() # 查看 qt5 实现斜着的水印效果
```

screen_watermark_qt5.py、screen_watermark_tkinter.py，可根据自己需要按需改写。

pyinstaller 打包

```
pyinstaller -w -F -i "C:\Users\administrator\Desktop\watermark\images\logo.ico" --onefile ^
--add-data "C:\Users\administrator\Desktop\watermark\images;images" ^ 
--name "屏幕加水印" --distpath "C:\Users\administrator\Desktop" "C:\Users\administrator\Desktop\watermark\main.py"
```

