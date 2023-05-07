import os
import re
import requests


def download_image(image_url: str, save_dir: str):
    """
    下载图片并保存到指定目录
    :param image_url: 图片的 URL
    :param save_dir: 保存目录
    """
    # 拆分图片 URL 以获取图片名称
    picture_name = re.split("[._]", image_url)
    # 拼接图片保存路径
    save_path = os.path.join(save_dir, f"{picture_name[1]}.{picture_name[4]}")
    # 请求图片的下载地址
    request = requests.post(f'https://cn.bing.com{image_url}')
    # 保存图片到本地
    with open(save_path, "wb") as f:
        f.write(request.content)
    print("下载完成:" + save_path)


def create_dir_if_not_exists(directory: str):
    """
    如果目录不存在，则创建它
    :param directory: 目录路径
    """
    if not os.path.exists(directory):
        os.makedirs(directory)


def main():
    # 模拟浏览器请求头
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
    }

    # 循环3次，即从首页到第三页
    for page_num in range(4):
        data = {
            "pageNum": page_num,
            "pageSize": 9
        }

        # 请求图片网站API，调用json参数
        request = requests.post('http://www.isummer.cn/x_site/wp/getWpList', json=data, headers=headers)

        # 拼接用户主目录下的 Pictures 文件夹路径
        default_pictures_dir = os.path.join(os.path.expanduser("~"), "Pictures")
        # 拼接成指定保存的图片目录
        picture_path = os.path.join(default_pictures_dir, "bing")
        # 如果目录不存在则创建
        create_dir_if_not_exists(picture_path)

        # 循环获取返回的图片地址
        for image in request.json()["data"]["list"]:
            # "wpUrl" 字符串中提取出第一个以 & 符号为分隔符的第一个字符串
            picture_list = image["wpUrl"].split("&")[0]
            download_image(picture_list, picture_path)


if __name__ == '__main__':
    main()
