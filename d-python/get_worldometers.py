from selenium import webdriver
from bs4 import BeautifulSoup
import csv
from datetime import datetime

# 参考
# BS文档：https://beautifulsoup.cn
# selenium：https://selenium-python-zh.readthedocs.io/en/latest/index.html

# ------------- webUI初始化配置 ----------------------------

driver = webdriver.Chrome()  
driver.get("https://www.worldometers.info/cn/")  

# 获取网页源码并传给 BeautifulSoup 解析
soup = BeautifulSoup(driver.page_source, 'html.parser')


# ------------将获取的数据提取出特定列，并写入到创建的csv------------- #

# 查找所有 <span class=item /> 与 <span class=rts-counter />
current_population_words = soup.find_all('span',class_='item')
current_population_num = soup.find_all('span',class_='rts-counter')


# ---------- 新增：以时间作为文件名后缀（2023-4-26） ---------------

# 获取当前时间
now = datetime.now()

# 将时间格式化为指定的字符串格式
formatted_time = now.strftime('%Y-%-m-%-d')


# ------------ 将获取的数据提取出特定列 ---------------------------

# 重复值标记
duplicate_value = 1
# 下标数以current_population_num为准
num_elements = len(current_population_num)

# 创建一个名为 "output.csv" 的 CSV 文件（旧）
# {} 占位符，在字符串中使用 {}，在 .format() 中传入相应的变量或者值来替换它
with open("worldometers_{}.csv".format(formatted_time), "w", newline='', encoding='utf-8-sig') as csvfile:
    # 指定列名
    fieldnames = ['Column A','Column B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # 写入表头
    writer.writeheader()

    for i in range(num_elements):
        duplicate_value = duplicate_value+1
        if duplicate_value == 52:
            continue
        row_data = {'Column A': current_population_words[i].text, 'Column B': current_population_num[i].text}
        writer.writerow(row_data)

