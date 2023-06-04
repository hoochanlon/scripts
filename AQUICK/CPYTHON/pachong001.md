## 简单爬虫示例一

### 简单入门

爬虫简例：

```python
import requests

url = 'https://www.example.com'
response = requests.get(url)
# 状态码正常
if response.status_code == 200:
    # wb 以二进制写入，以避免出现编码转换错误和数据截断等问题，稳定且通用。
    # 在 with 块中打开的资源会在块结束时自动关闭，无论原始代码是否引发异常。
    with open('example.html', 'wb') as f:
        f.write(response.text)
    print('网页内容已保存到 example.html 文件！')
else:
    print('请求失败。')
```

文档：

* https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files
* https://requests.readthedocs.io/en/latest/

### 更改保存位置

 [吾爱破解 -【shell】压缩包密码暴破脚本  #5](https://www.52pojie.cn/forum.php?mod=redirect&goto=findpost&ptid=1775990&pid=46442685) 所提到的“提一嘴python的跨平台，可以用os.path或者[pathlib](https://docs.python.org/zh-cn/3/library/pathlib.html)模块规范化路径”。有必要试用一下。

```python
  import os
  # 1. 获取用户下载目录（使用 os.path.expanduser 方法）
  download_dir = os.path.join(os.path.expanduser('~'), 'Downloads')
  # 2.  拼接文件路径（使用 os.path.join 方法）
  file_path = os.path.join(download_dir, 'example.html')
```

整合  `file_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'example.html')`

文档：[csdn-python3文件路径操作常用方法带示例详解（os.path模块，os.listdir，os.walk，os.scandir方法等）（不定期更新整理中）](https://blog.csdn.net/yl19870518/article/details/128572201)

###  转换成PDF

文档：https://github.com/JazzCore/python-pdfkit (注意 `brew install wkhtmltopdf`)

```python
import pdfkit
import requests

url = 'https://www.example.com/'
response = requests.get(url)

# 将网页内容转换为 PDF 并保存到本地
pdfkit.from_string(response.text, 'example.pdf')
```

### 整合

```python
import requests,pdfkit,os

url = 'https://www.example.com'
download_dir = os.path.join(os.path.expanduser('~'), 'Downloads')
file_path = os.path.join(download_dir, 'example.pdf')

response = requests.get(url)
# 状态码正常
if response.status_code == 200:
    pdfkit.from_string(response.text,file_path)
else:
    print('请求失败。')
```

