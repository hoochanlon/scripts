## bossAPI分析

## 初步观察

### 招聘条目

招聘条目API

```
https://www.zhipin.com/wapi/zpgeek/search/joblist.json?scene=1&query=IT%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81&city=101280600&experience=&payType=&partTime=&degree=&industry=&scale=&stage=&position=&jobType=&salary=&multiBusinessDistrict=&multiSubway=&page=1&pageSize=30
```
 招聘条目web链接分析

```
https://www.zhipin.com/web/geek/job?query=IT%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81&city=101280600&experience=106&salary=405
```

参数分析

```
city=101280600 深圳
experience=105 3-5年
salary=405 10-20k
```

通过分析为utf-8编码

```python
from urllib.parse import unquote

encoded_str = '%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81'
decoded_str = unquote(encoded_str, encoding='utf-8')
print(decoded_str)
```

### 城市代码

```
https://www.zhipin.com/wapi/zpCommon/data/cityGroup.json
```

```python
code_value = city_json["zpData"]["cityGroup"][0]["cityList"][0]["code"]
```

```python
# 假设您已经将 JSON 数据加载到了 city_json 字典中

user_city = input("请输入城市：")  # 获取用户输入的城市名

city_code = None  # 初始化城市编码为 None

# 遍历城市列表，查找与用户输入城市名匹配的城市信息
for group in city_json["zpData"]["cityGroup"]:
    for city in group["cityList"]:
        if city["name"] == user_city:
            city_code = city["code"]
            break

if city_code is not None:
    print("匹配到的城市编码：", city_code)
else:
    print("未找到匹配的城市编码")

```

##  cookie写法

写法一

```python
import requests
import json
import http.cookies
import urllib.request

# 将字符串的 cookie 转换成字典dict类型的。
input_cookie = input("请复制Cookie：")
cookie = http.cookies.SimpleCookie()
cookie.load(input_cookie)
cookie_dict = {}
for key, morsel in cookie.items():
    cookie_dict[key] = morsel.value

# 设置请求头，并将字典类型的 cookie 转换成字符串类型的。
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36',
    'Cookie': '; '.join([f'{key}={value}' for key, value in cookie_dict.items()]),
}
```

写法二

```python
import requests

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36',
}

cookies = {
    'key1': 'value1',
    'key2': 'value2',
}

response = requests.get(url, headers=headers, cookies=cookies)

```

## 整理分析

将一开始的API进行精简化

```
https://www.zhipin.com/wapi/zpgeek/search/joblist.json?query=IT%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81&city=101280600&experience=105&salary=405&page=1&pageSize=30
```



### boss api json拼接结构

注: 直接加载json会导致json格式错误，而放在本地读取却是正常的。

https://github.com/hoochanlon/scripts/blob/main/d-json/exam_zhipin_demo.json

具体结构树

```
[
    {
        "code": 0,
        "message": "Success",
        "zpData":{
            "jobList": [
                {

                }
            ]
        }
    },
    {
        "code": 0,
        "message": "Success",
        "zpData":{
            "jobList": [
                {

                }
            ]
        }
    }
]
```

循环取出

```
        data_list = []
        for item in zhipin_json:
            if "zpData" in item and "jobList" in item["zpData"]:
                data_list.extend(item["zpData"]["jobList"])

        for job in data_list:
```

### 本地测试代码

```python
import os
import re
import platform
import requests
import json
import urllib.request
from openpyxl import Workbook
from datetime import datetime


class GetDataTools:
    @staticmethod
    def get_citycode(input_city):
        response = urllib.request.urlopen('https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-json/bosszhipin_citycode.json')
        city_json = json.loads(response.read().decode('utf-8'))

        city_code = None
        for group in city_json["zpData"]["cityGroup"]:
            for city in group["cityList"]:
                if city["name"] == input_city:
                    city_code = city["code"]
                    return city_code
        return None

    @staticmethod
    def validate_cookie(input_cookie):
        cookie_list = input_cookie.split("; ")
        cookies_dict = {}

        try:
            for item in cookie_list:
                key, value = item.strip().split("=", 1)
                cookies_dict[key] = value
        except ValueError:
            return False

        return True


class ZhiPin:
    @staticmethod
    def get_job_list():
        input_keywords = input("请输入查询职位：")
        input_city = input("请输入城市：")
        city_code = GetDataTools.get_citycode(input_city)
        while city_code is None:
            print("未找到匹配的城市编码，请重新输入城市名。")
            input_city = input("请输入城市：")
            city_code = GetDataTools.get_citycode(input_city)

        # input_num = input("请输入需要遍历的页码：")
        input_cookie = input("请复制Cookie：")
        # while not GetDataTools.validate_cookie(input_cookie):
        #     input_cookie = input("请重新复制Cookie：")

        job_data_list = []

        for page in range(1,3):
            url = f'https://www.zhipin.com/wapi/zpgeek/search/joblist.json?query={input_keywords}&city={city_code}&experience=105&salary=405&page={page}&pageSize=30'

            headers = {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36',
                'Cookie': input_cookie,
            }

            data = requests.get(url, headers=headers).json()
            job_data_list.append(data)

        return job_data_list

    @staticmethod
    def save_to_json(job_data_list):
        save_json = os.path.join(
            os.path.join(os.path.expanduser("~"), "Desktop"),
            "boss_{}.json".format(datetime.now().strftime('%Y-%m-%d'))
        )

        with open(save_json, 'w', encoding='utf-8') as f:
            json.dump(job_data_list, f, ensure_ascii=False, indent=4)

        return save_json


class DataToExcel:
    @staticmethod
    def save_to_excel(workbook, zhipin_json):

        with open(zhipin_json, 'r', encoding='utf-8') as f:
            zhipin_json = json.load(f)

        worksheet = workbook.create_sheet(title='招聘信息清单')

        titles = [
            '职位', '技能', '经验', '学历', '工资', '福利',
            '公司', '公司类型', '人数规模', '融资状态', '地址'
        ]

        for col, title in enumerate(titles, start=1):
            worksheet.cell(row=1, column=col, value=title)

        data_list = []
        for item in zhipin_json:
            if "zpData" in item and "jobList" in item["zpData"]:
                data_list.extend(item["zpData"]["jobList"])

        row = 2
        column = 1

        for job in data_list:
            worksheet.cell(row=row, column=column, value=job['jobName'])
            column += 1
            worksheet.cell(row=row, column=column, value='; '.join(job['skills']))
            column += 1
            worksheet.cell(row=row, column=column, value=job['jobExperience'])
            column += 1
            worksheet.cell(row=row, column=column, value=job['jobDegree'])
            column += 1
            worksheet.cell(row=row, column=column, value=job['salaryDesc'])
            column += 1
            worksheet.cell(row=row, column=column, value='; '.join(job['welfareList']))
            column += 1
            worksheet.cell(row=row, column=column, value=job['brandName'])
            column += 1
            worksheet.cell(row=row, column=column, value=job['brandIndustry'])
            column += 1
            worksheet.cell(row=row, column=column, value=job['brandScaleName'])
            column += 1
            worksheet.cell(row=row, column=column, value=job['brandStageName'])
            column += 1
            worksheet.cell(row=row, column=column, value=f"{job['cityName']} {job['areaDistrict']} {job['businessDistrict']}")
            column += 1

            row += 1
            column = 1

        # 添加新的sheet并写入相关的行列数据
        extra_sheet = workbook.create_sheet(title='就业反欺诈')
        extra_data = [
            ['主题', '链接'],
            ['就业形势分析及预防欺诈对策', 'https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/就业形势分析及预防欺诈对策.ipynb'],
            ['同济大学王荣昌-给初涉社会年轻人的忠告', 'https://blog.sciencenet.cn/blog-348492-375365.html'],
            ['适合中文的简历模板收集', 'https://github.com/dyweb/awesome-resume-for-chinese'],
        ]

        for row, data_row in enumerate(extra_data, start=1):
            for col, value in enumerate(data_row, start=1):
                extra_sheet.cell(row=row, column=col, value=value)


if __name__ == '__main__':
    # job_data_list = ZhiPin.get_job_list()
    # zhipin_json = ZhiPin.save_to_json(job_data_list)

    workbook = Workbook()
    workbook.remove(workbook.active)
    DataToExcel.save_to_excel(workbook, os.path.join(
            os.path.join(os.path.expanduser("~"), "Desktop"),
            "boss_{}.json".format(datetime.now().strftime('%Y-%m-%d'))
        ))
    save_xlsx = os.path.join(
        os.path.join(os.path.expanduser("~"), "Desktop"),
        "boss_{}.xlsx".format(datetime.now().strftime('%Y-%m-%d'))
        )
    workbook.save(save_xlsx)
```

