# demo py

## 获取网站标题

简单的获取网站标题 demo

```
import requests
from bs4 import BeautifulSoup

# 定义需要爬取的网页链接
url = 'https://www.baidu.com/'

# 使用requests库获取页面内容
html = requests.get(url).content

# 使用BeautifulSoup解析HTML文件，并找到页面标题
soup = BeautifulSoup(html,'lxml')
title = soup.title.string

# 输出页面标题
print('Title is:', title)
```

设置防爬

```
# 设置请求头，防止反爬
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}

# 定义需要爬取的网页链接
url = 'https://www.baidu.com/'

# 使用requests库获取页面内容
html = requests.get(url, headers=headers).content
```

## 获取网站指定元素内容

因为是实时数据，所以会显示为 "世界人口： 数据获取中..."，只能通过webui自动化来实现了。

参考[51cto-静态网页爬虫① ](https://blog.51cto.com/u_15743016/5549456)

```
import requests
import time
from bs4 import BeautifulSoup

url = "https://www.worldometers.info/cn/"

# 使用 requests 库获取页面内容
r = requests.get(url)
html_content = r.content

# 使用 BeautifulSoup 解析 HTML 文件，并找到页面中指定的元素（这里以世界人口为例）
soup = BeautifulSoup(html_content, 'html.parser')

world_population_element = soup.find_all('div', attrs={'class': 'counter'})[0].find('span')

# 输出世界人口数据
print("世界人口：", world_population_element.text)
```

通过 [cnblogs -（数据科学学习手札50）基于Python的网络数据采集-selenium篇（上）](https://www.cnblogs.com/feffery/p/9570171.html)、[csdn-基于python爬虫————静态页面和动态页面爬取](https://blog.csdn.net/qq_52661119/article/details/119854694) 这两篇文章，看来目前的通行办法就是webUI自动化了。