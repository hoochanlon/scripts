import requests 
from bs4 import BeautifulSoup 
from openpyxl import Workbook 
from datetime import datetime

# 获取当前时间 
now = datetime.now() 
# 将时间格式化为指定的字符串格式 
formatted_time = now.strftime('%Y-%m-%d')

# ---------- 获取相关热搜新闻保存到xlsx ------------------

def resou_to_excel(url, sheet_name, wb):
    # 套用代码
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                             '(KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    r = requests.get(url, headers=headers)
    r.encoding = 'utf-8'
    soup = BeautifulSoup(r.text, 'html.parser')
    toutiao_resoubang = soup.find_all('div', class_='single-entry tindent')

    # 创建初始数组，遍历span元素，保存到该数组中。
    resoubang_list = []
    for item in toutiao_resoubang:
        spans = item.find_all('span')
        for span in spans:
            resoubang_list.append(span.string)
    # 创建相应的表单，write_to_excel(urls[i], sheet_names[i], wb)
    ws = wb.create_sheet(title=sheet_name)

    row = []
    # 使用enumerate()，定位索引位置
    for i, item in enumerate(resoubang_list, start=1):
        # 取模；如果是每组的第一个元素，则将其内容中的"、"删除
        if i % 3 == 1:  
            item = item.replace("、", "")
        row.append(item)
        # 取模；余数为0，即三个一组，新行起
        if i % 3 == 0:
            ws.append(row)
            row = []
    # 如果行有数据则继续追加
    # if row:
    #     ws.append(row)
    
  # ----- 将A列和C列除表头以外的数据转为数值类型-----------

    # https://openpyxl.readthedocs.io/en/stable/index.html

    # ws.iter_rows()函数用于按行迭代工作表中的单元格对象
    # min_row和min_col参数指定了起始行和列
    for row in ws.iter_rows(min_row=2, min_col=1):
        for cell in row:
            # 只对A列和C列进行转换
            if cell.column == 1 or cell.column == 3:  
                # 判断单元格的值是否为字符串且都为数字
                if isinstance(cell.value, str) and cell.value.isnumeric():
                    cell.value = int(cell.value)
                # 判断单元格的值是否为字符串，去掉w
                elif isinstance(cell.value, str):
                    cell.value = float(cell.value.replace('w', ''))
    
    ws.cell(row=1, column=3, value='指数（万）')  # 修改C列的标题

# 在此处添加需要爬取的URL和sheet名称 
urls = ['http://resou.today/art/11.html', 'http://resou.today/art/22.html', 'http://resou.today/art/10.html'] 
sheet_names = ['今日头条热榜', '抖音时事热榜', '百度热搜']

# 创建了一个新的Excel工作簿
wb = Workbook()

# 有多少链接就执行几遍这方法
for i in range(len(urls)):
    resou_to_excel(urls[i], sheet_names[i], wb)

# 删除默认生成的空白 sheet
default_sheet = wb['Sheet']
wb.remove(default_sheet)
wb.save('resoubang_{}.xlsx'.format(formatted_time))
