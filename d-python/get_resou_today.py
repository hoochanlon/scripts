import os
from datetime import datetime

import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook


def get_formatted_time():
    """
    获取格式化后的当前时间
    :return: 格式化后的当前时间字符串
    """
    now = datetime.now()
    return now.strftime('%Y-%m-%d')


def create_dir_if_not_exists(directory: str):
    """
    如果目录不存在，则创建它
    :param directory: 目录路径
    """
    if not os.path.exists(directory):
        os.makedirs(directory)


def get_news_from_url(url: str):
    """
    从指定的 URL 抓取热搜新闻
    :param url: 网页 URL
    :return: 热搜新闻列表
    """
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                      '(KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    r = requests.get(url, headers=headers)
    r.encoding = 'utf-8'
    soup = BeautifulSoup(r.text, 'html.parser')
    toutiao_resoubang = soup.find_all('div', class_='single-entry tindent')

    resoubang_list = []
    for item in toutiao_resoubang:
        spans = item.find_all('span')
        for span in spans:
            resoubang_list.append(span.string)
    return resoubang_list


def write_news_to_sheet(news_list: list, sheet_name: str, wb: Workbook):
    """
    将新闻列表写入到 Excel 工作表中
    :param news_list: 新闻列表
    :param sheet_name: 工作表名称
    :param wb: Excel 工作簿对象
    """
    ws = wb.create_sheet(title=sheet_name)

    row = []
    for i, item in enumerate(news_list, start=1):
        if i % 3 == 1:
            item = item.replace("、", "")
        row.append(item)
        if i % 3 == 0:
            ws.append(row)
            row = []

    for row in ws.iter_rows(min_row=2, min_col=1):
        for cell in row:
            if cell.column == 1 or cell.column == 3:
                if isinstance(cell.value, str) and cell.value.isnumeric():
                    cell.value = int(cell.value)
                elif isinstance(cell.value, str):
                    cell.value = float(cell.value.replace('w', ''))

    ws.cell(row=1, column=3, value='指数（万）')


def delete_empty_rows(sheet_name: str, wb: Workbook):
    """
    删除指定工作表中的空行
    :param sheet_name: 工作表名称
    :param wb: Excel 工作簿对象
    """
    ws = wb[sheet_name]
    for row in ws.iter_rows():
        if all(cell.value is None for cell in row):
            ws.delete_rows(row[0].row)


def calculate_average_index(sheet_name: str, wb: Workbook):
    """
    计算指定工作表中热搜新闻的平均指数
    :param sheet_name: 工作表名称
    :param wb: Excel 工作簿对象
    :return: 平均指数
    """
    ws = wb[sheet_name]
    total_index = 0
    count = 0
    for row in ws.iter_rows(min_row=2, min_col=3, max_col=3):
        for cell in row:
            total_index += cell.value
            count += 1
    return total_index / count


def main():
    default_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    save_path_xlsx_file = os.path.join(default_dir,
                                       "resoubang_{}.xlsx".format(get_formatted_time()))

    urls = ['http://resou.today/art/11.html', 'http://resou.today/art/22.html',
            'http://resou.today/art/10.html']
    sheet_names = ['今日头条热榜', '抖音时事热榜', '百度热搜']

    wb = Workbook()

    for url, sheet_name in zip(urls, sheet_names):
        news_list = get_news_from_url(url)
        write_news_to_sheet(news_list, sheet_name, wb)
        delete_empty_rows(sheet_name, wb)
         print(sheet_name + ' 平均指数:' + str(calculate_average_index(sheet_name, wb)))

    default_sheet = wb['Sheet']
    wb.remove(default_sheet)
    wb.save(save_path_xlsx_file)


if __name__ == '__main__':
    main()
