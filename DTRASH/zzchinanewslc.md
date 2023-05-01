# 制作中国新闻网爬虫的历程

这主要是受[csdn-Python爬取新闻信息，分词统计并画词云](https://blog.csdn.net/xukeke12138/article/details/117167932)启发，中途也写了百度热搜的爬虫，对繁杂的新闻条目进行精细分类，涉及到AI与机械学习方面，工程量还是太大了，那我不如用这个中过新闻网现成的分类。考虑到文章源码相对来说并不是那么易读，以及附加了词云之类的库，要想跨平台还是有些不便，就自己写一个吧。

## 编码过程

### 01 simple demo（标题遍历）

简单试手遍历新闻标题，如图div部分，“lm”、“time”，都能进行简单的遍历。

![catch2023-04-30 21.31.51](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-04-30%2021.31.51.png)

01 simple demo 源码

```python
import requests
from bs4 import BeautifulSoup

# ---- 常规操作 -------

url = 'https://www.chinanews.com.cn/scroll-news/news1.html'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
}
r = requests.get(url, headers=headers)
r.encoding='utf-8'
soup = BeautifulSoup(r.text, 'html.parser')

# ----- 遍历 ---------

dangdu_biaoti = soup.find_all('div', class_='dd_bt')

for div in dangdu_biaoti:
    print(div.text)
```

效果如下

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-04-30%2021.16.04.png)

### 02 simple demo（页码遍历）

https://www.chinanews.com.cn/scroll-news/news1.html  ，做个遍历链接，再遍历内容也是可行的。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-04-30%2021.48.40.png)

02 simple demo 源码

```python
import requests
from bs4 import BeautifulSoup

# ---- 遍历页码从1到10 -------
for i in range(1, 11):
    # f-string
    url = f"https://www.chinanews.com.cn/scroll-news/news{i}.html"
    # 反爬通用套码
    headers = {
     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
}
    r = requests.get(url, headers=headers)
    r.encoding='utf-8'
    soup = BeautifulSoup(r.text, 'html.parser')

    # ----- 遍历标题 （dd_time dd_lm 已测可行） ---------
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    for div in dangdu_biaoti:
        print(div.text)
```

### 03 simple demo（debug）

**不恰当的for循环逻辑，导致各列各项“错位”**

错误演示demo

```python
# 错位了
    # 遍历栏目 
    dangdu_lanmu = soup.find_all('div', class_='dd_lm')
    for div in dangdu_lanmu:
        # 将标题文本写入第2列（即A列），第row+1行中
        sheet.write(row, 0, div.text)
        row += 1  # 写入下一行

    # 遍历标题 （dd_time dd_lm 已测可行）
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    for div in dangdu_biaoti:
        # 将标题文本写入第2列（即B列），第row+1行中
        sheet.write(row, 1, div.text)
        row += 1  # 写入下一行

    # 遍历时间
    dangdu_time = soup.find_all('div', class_='dd_time')
    for div in dangdu_time:
        # 将标题文本写入第2列（即C列），第row+1行中
        sheet.write(row, 2, div.text)
        row += 1  # 写入下一行
```

A、B、C列发生了偏移

![catch2023-04-30 23.59.05](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-04-30%2023.59.05.png)

**将A、B、C列的项目并排齐头的二种方式**

方式一：先把表头占据，2起步。

```python
# 添加表头
sheet['A1'] = '栏目'
sheet['B1'] = '标题'
sheet['C1'] = '时间'

# 定义变量row，用于循环时控制每一行的写入位置
row = 2

    # 遍历栏目、标题和时间
    dangdu_lanmu = soup.find_all('div', class_='dd_lm')
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    dangdu_time = soup.find_all('div', class_='dd_time')
    
    for j in range(len(dangdu_lanmu)):
        # 将栏目、标题和时间分别写入第1列、第2列和第3列，第j+row行中
        sheet.cell(row=row, column=1, value=dangdu_lanmu[j].text)
        sheet.cell(row=row, column=2, value=dangdu_biaoti[j].text)
        sheet.cell(row=row, column=3, value=dangdu_time[j].text)
```

同理于

```python
# 添加表头
sheet.write(0, 0, '栏目')
sheet.write(0, 1, '标题')
sheet.write(0, 2, '时间')

# 定义变量row，用于循环时控制每一行的写入位置
row = 1

    # 遍历栏目、标题和时间
    dangdu_lanmu = soup.find_all('div', class_='dd_lm')
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    dangdu_time = soup.find_all('div', class_='dd_time')
    
    for j in range(len(dangdu_lanmu)):
        # 将栏目、标题和时间分别写入第1列、第2列和第3列，第j+row行中
        sheet.cell(row=row, column=1, value=dangdu_lanmu[j].text)
        sheet.cell(row=row, column=2, value=dangdu_biaoti[j].text)
        sheet.cell(row=row, column=3, value=dangdu_time[j].text)
```

方式二：使用append，精简化

```python
# 定义变量row，用于循环时控制每一行的写入位置
row = 1

# 添加表头
sheet['A1'] = '栏目'
sheet['B1'] = '标题'
sheet['C1'] = '时间'

   # 遍历栏目、标题和时间
    dangdu_lanmu = soup.find_all('div', class_='dd_lm')
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    dangdu_time = soup.find_all('div', class_='dd_time')
    
    # 追加具体数据
    for news_num in range(len(dangdu_lanmu)):
        sheet.append([dangdu_lanmu[news_num].text, dangdu_biaoti[news_num].text, dangdu_time[news_num].text])
        # row=row+1
        row += 1
```

效果如图

![catch2023-05-01 00.23.35](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2000.23.35.png)

03 simple demo

```python
import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook

# -----参考文档，三件套-------
# https://docs.python-requests.org/en/latest/
# https://www.crummy.com/software/BeautifulSoup/bs4/doc/
# https://openpyxl.readthedocs.io/en/stable/
# -----参考文档，三件套-------

# 创建一个Workbook对象，用于Excel的读写
wb = Workbook()

# 添加一个Sheet页，并且指定Sheet名称
sheet = wb.active
sheet.title = 'Sheet1'

# 定义变量row，用于循环时控制每一行的写入位置
row = 1

# 添加表头
sheet['A1'] = '栏目'
sheet['B1'] = '标题'
sheet['C1'] = '时间'

# 遍历页码从1到2
for page_num in range(1,2):
    # f-string
    url = f"https://www.chinanews.com.cn/scroll-news/news{page_num}.html"

    # 反爬通用套码
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }

    r = requests.get(url, headers=headers)
    r.encoding='utf-8'
    soup = BeautifulSoup(r.text, 'html.parser')

    # 遍历栏目、标题和时间
    dangdu_lanmu = soup.find_all('div', class_='dd_lm')
    dangdu_biaoti = soup.find_all('div', class_='dd_bt')
    dangdu_time = soup.find_all('div', class_='dd_time')
    
    # 追加具体数据
    for news_num in range(len(dangdu_lanmu)):
        sheet.append([dangdu_lanmu[news_num].text.strip('[]'), dangdu_biaoti[news_num].text, dangdu_time[news_num].text])
        # row=row+1
        row += 1

# 保存Excel文件
wb.save('output.xlsx')

```

## 做统计饼图遇到的问题

### 01 数据格式

代码生成的output.xlsx清除内容做了简单的数据统计测试，出现了饼图“不显示”的问题，但新建的Excel表填入一样数据，测试后却并没问题。

问题如图所示

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/644f6144e2085.png)

中途发现：[知乎专栏-用原生的方式操作Excel，Python玩转Excel神器xlsxwriter详解！](https://zhuanlan.zhihu.com/p/350242120)、[csdn-python实现——处理Excel表格（超详细）](https://blog.csdn.net/weixin_44288604/article/details/120731317)；最后参考这篇[csdn-excel无法做图，是因为数据格式的原因](https://blog.csdn.net/weixin_41470864/article/details/88928506)解决的，我推测这个问题是我复制了表头，随手粘贴连同属性也一块复制进去了，所造成的。

![catch2023-05-01 13.45.49](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2013.45.49.png)





### 02 筛选统计

无意间点到数据透视图，如下图以标题对应着栏目数，查了 [microsoft-设计数据透视表的布局和格式](https://support.microsoft.com/zh-cn/office/设计数据透视表的布局和格式-a9600265-95bf-4900-868e-641133c05a80)对“轴”与“值”的说明，我觉得其类似于键值对的设计，当做统计汇总时，“轴”相当于分组和分类的列、"值"相当于的统计的数目的列。

![](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2018.46.04.png)

问及人资同事有关于报表方面的制作，他推荐了 https://www.tubiaoxiu.com ，从使用上确实简单了不少。

![201682934896_.pic](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/201682934896_.pic.jpg)
