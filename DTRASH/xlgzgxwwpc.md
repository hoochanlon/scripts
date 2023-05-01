# 写了一个中国新闻网爬虫

**免责声明：此爬虫仅供学习和研究目的使用。使用者应遵守相关国家和地区的法律法规，不得将本爬虫用于任何违反法律法规或侵犯他人合法权益的行为。最后，使用者应自行承担使用本爬虫所带来的风险和责任。如果不同意以上声明，你应该立即停止使用本爬虫。**

这主要是受[csdn-Python爬取新闻信息，分词统计并画词云](https://blog.csdn.net/xukeke12138/article/details/117167932)启发，中途也写了百度热搜的爬虫，对繁杂的新闻条目进行精细分类，涉及到AI与机械学习方面，我试了试，觉得工程量还是太大了，还不如用这个中国新闻网现成的分类。再考虑到上述文章的源码不大易读，以及附加了词云之类的库，要想跨平台还是有些不便，就自己写一个吧。

本地测试，效果如图：

![catch2023-05-01 21.13.59](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2021.13.59.png)

（注：Windows多半是要注释掉 `r.encoding='utf-8'` ，保存路径多半是家目录或`c:/Windows/System32`）

在线测试

```
python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_chinanews.py)"
```

![catch2023-05-01 21.34.55](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2021.34.55.png)

附源码：https://github.com/hoochanlon/ihs-simple/blob/main/d-python/get_chinanews.py 

```
import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook
from datetime import datetime
# -----参考文档，三件套-------
# https://docs.python-requests.org/en/latest/
# https://www.crummy.com/software/BeautifulSoup/bs4/doc/
# https://openpyxl.readthedocs.io/en/stable/
# https://docs.python.org/3/library/stdtypes.html#str.strip （切片）
# -----参考文档，三件套-------
# 5.1 新增时间格式规范化输出文件名
# 获取当前时间
now = datetime.now()
# 将时间格式化为指定的字符串格式
formatted_time = now.strftime('%Y-%-m-%-d')
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
# 遍历页码1从2页
for page_num in range(1,3):
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
wb.save("chinanews_{}.xlsx".format(formatted_time))
```

配合一些大数据分析的论文食用更佳：

* 许诺、唐锡晋 -《基于百度热搜新闻词的社会风险事件5W提取研究》（中国科学院、中国科学院大学，《系统工程理论与实践》，Vol.40, No.2, Feb., 2020）
* 毛贺祺 -《大数据背景下微博热搜的新闻阅读服务功能》（吉林大学文学院, 2017年3月）
* 王小新 -《当前我国受众网络新闻的阅读...读倾向——以百度热搜词为例》（上海理工大学，《今传媒》2013年第9期）
* 喻国明 -《大数据分析下的中国社会舆情 总体态势与结构性特征》（中国人民大学，中国人民大学学报，2013年第5期）

举例来说，就是简单的数据对比与分析：

![catch2023-05-01 22.15.40](https://cdn.jsdelivr.net/gh/hoochanlon/ihs-simple/AQUICK/catch2023-05-01%2022.15.40.png)
