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

# 遍历页码从1到10
for page_num in range(1,11):
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
