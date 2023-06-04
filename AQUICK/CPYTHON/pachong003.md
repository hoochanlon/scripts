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

## 获取网站指定元素内容0.1

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


## 获取网站指定元素内容0.2

```
import sys
from selenium import webdriver
from bs4 import BeautifulSoup

driver = webdriver.Chrome()  # 声明浏览器对象，使用 Chrome 浏览器
driver.get("https://www.worldometers.info/cn/")  # 跳转到指定网址

# 获取网页源码并传给 BeautifulSoup 解析
soup = BeautifulSoup(driver.page_source, 'html.parser')

# 使用 select_one() 方法获取第一个匹配要求的元素
current_population_words = soup.select_one('span.item')

# 使用 select_one() 方法获取第一个匹配要求的元素
current_population_numbers = soup.select_one('span.rts-counter')

# BS文档：https://beautifulsoup.cn
# selenium：https://selenium-python-zh.readthedocs.io/en/latest/index.html

print(current_population_words.text, current_population_numbers.text)
```

## demo

遍历 https://www.worldometers.info/cn 列表统计

```python
from selenium import webdriver
from bs4 import BeautifulSoup

# 参考
# BS文档：https://beautifulsoup.cn
# selenium：https://selenium-python-zh.readthedocs.io/en/latest/index.html

driver = webdriver.Chrome()  # 声明浏览器对象，使用 Chrome 浏览器
driver.get("https://www.worldometers.info/cn/")  # 跳转到指定网址

# 获取网页源码并传给 BeautifulSoup 解析
soup = BeautifulSoup(driver.page_source, 'html.parser')

# 查找所有 <span class=item /> 与 <span class=rts-counter />
current_population_words = soup.find_all('span',class_='item')
current_population_num = soup.find_all('span',class_='rts-counter')

for current_population_words in current_population_words:
    print(current_population_words.text)

for current_population_num in current_population_num:
    print(current_population_num.text)
```

## 格式左右不对齐

```python
# 创建一个名为 "output.csv" 的 CSV 文件
with open("output.csv", "w", newline='', encoding='utf-8-sig') as csvfile:
    # 指定列名
    fieldnames = ['Column A', 'Column B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # 写入表头
    writer.writeheader()
    for current_population_words in current_population_words:
        # 写入数据
        writer.writerow({'Column A': current_population_words.text})

    for current_population_num in current_population_num:
        writer.writerow({'Column B': current_population_num.text})
```

## 理想情况

A列数与比B列数相一致，但堕胎项存在重复

```python
# 查找所有 <span class=item /> 与 <span class=rts-counter />
current_population_words = soup.find_all('span',class_='item')
current_population_num = soup.find_all('span',class_='rts-counter')


# 创建一个名为 "output.csv" 的 CSV 文件
with open("output.csv", "w", newline='', encoding='utf-8-sig') as csvfile:
    # 指定列名
    fieldnames = ['Column A', 'Column B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # 写入表头
    writer.writeheader()

    for i in range(num_elements):
        row_data = {'Column A': current_population_words[i].text, 'Column B': current_population_num[i].text}
        writer.writerow(row_data)
```

## 卡bug

最后通过if continue这样卡bug搞定，故意从53行开始，而excel却是按着52行表写的，抵消掉了多余重复行带来的困扰。

```python
# 重复值标记
duplicate_value = 1
# 下标数以current_population_num为准
num_elements = len(current_population_num)

# 创建一个名为 "output.csv" 的 CSV 文件
with open("output.csv", "w", newline='', encoding='utf-8-sig') as csvfile:
    # 指定列名
    fieldnames = ['Column A','Column B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)


# 创建一个名为 "output.csv" 的 CSV 文件
with open("output.csv", "w", newline='', encoding='utf-8-sig') as csvfile:
    # 指定列名
    fieldnames = ['Column A', 'Column B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # 写入表头
    writer.writeheader()

    for i in range(num_elements):
        duplicate_value = duplicate_value+1
        if duplicate_value == 52:
            continue
        row_data = {'Column A': current_population_words[i].text, 'Column B': current_population_num[i].text}
        writer.writerow(row_data)
```








