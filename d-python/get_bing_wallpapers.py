import requests
import re
import os

# 模拟浏览器请求
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
}

# getWpList json 部分参数
# data = {
#     "pageNum": 1,
#     "pageSize": 9
# }


# 循环3次，即从首页到第三页
# "pageNum" 页码；pageSize，最多9张图。
for i in range(4):
    data = {
        "pageNum": i,
        "pageSize": 9
    }

    # 请求图片网站API，调用json参数
    request = requests.post('http://www.isummer.cn/x_site/wp/getWpList', json=data, headers=headers)


    # 拼接用户主目录下的 Pictures 文件夹路径
    default_pictures_dir = os.path.join(os.path.expanduser("~"), "Pictures")
    # 拼接成指定保存的图片目录
    picture_path = os.path.join(default_pictures_dir, "bing")
    # 如果目录不存在则创建
    if not os.path.exists(picture_path):
        os.makedirs(picture_path)

    # 测试现象
    # /th?id=OHR.Popocatepetl_ZH-CN5483138337_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp

    # 循环获取返回的图片地址
    for i in request.json()["data"]["list"]:
        # "wpUrl" 字符串中提取出第一个以 & 符号为分隔符的第一个字符串
        picture_list = i["wpUrl"].split("&")[0]
        # print(picture_list) 返回结果：/th?id=OHR.SouthPadre_ZH-CN8788572569_1920x1080.jpg
        # 采取策略：先分割后拼接
        # picture_name = picture_list.split(".") # 返回结果：['/th?id=OHR', 'SouthPadre_ZH-CN8788572569_1920x1080', 'jpg']
        picture_name=re.split("[._]", picture_list)

        # 拼接图片保存路径
        save_path = os.path.join(picture_path, f"{picture_name[1]}.{picture_name[4]}")
        
        # 请求图片的下载地址
        request = requests.post(f'https://cn.bing.com{picture_list}')
        # 保存图片到本地
        with open(save_path, "wb") as f:
            f.write(request.content)

        print("下载完成:" + save_path)


