# 写了一个关于 worldmeter 的爬虫

worldometerworldometer这里提供关于人口、政府、经济、社会、媒体、环境、食物、水、能源和健康的世界实时统计数据的网站。实时数据，一时半会没什么用，看个乐子，但如果我们想它保存为季度、年度的分类，那价值还挺高的。基于这个想法，我才做的这方面的爬虫。

这是第三次写python脚本了吧，第一次是jupyter测试写笔记、玩玩简单数据可视化，第二次是NTFS for Mac，第三次就爬虫这次了，之后再此基础上，整点数据可视化的东西看看效果。

爬虫csv效果（仅39、40，略有瑕疵，删掉多余 `=-` ，问题不大）

![](https://s2.xptou.com/2023/04/27/64495cb2a2439.png)


本地及在线测试图

![](https://s2.xptou.com/2023/04/27/6449ce821f7d9.png)

在线测试

`python -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/ihs-simple/main/d-python/get_worldometers.py)"`

![](https://s2.xptou.com/2023/04/27/6449ce821f7d9.png)

**Windows运行的话，一般是在c:/Windows/System32或自己的家目录**

附源码：https://github.com/hoochanlon/ihs-simple/blob/main/d-python/get_worldometers.py

```python
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

```


## worldmeter后记

### 缘起

一开始本打算写开放研究论文综合搜索 [core.ac.uk](https://core.ac.uk) 的批量下载并匹配文献书名的爬虫，但后来一想，自己似乎没什么实质性的必要。以前看知网、复印刊、院校报（社科版）的比较多，后来随着工作与生活中的琐事所占时间越来越多，相对来说逐渐慢慢地也看得少了，一个月下来，平时偶尔看了一两篇就不错了。

举个例来说，就以[陈武元-《日本高等教育与经济发展的关系》](https://core.ac.uk/download/pdf/41446488.pdf) 链接为例

* https://core.ac.uk/download/pdf/41446488.pdf
* https://core.ac.uk/reader/41446488

download、reader都挺有规律性的，将“41446488”改成 https://core.ac.uk/reader/41446487，就是《日本高等教育改革的动向》的论文。也挺适合爬的，但没这么做，原因前面也说了。后来搜集统计相关的资料，找到了[knoema](https://cn.knoema.com)、[worldometers](https://www.worldometers.info/cn/)，看到[worldometers](https://www.worldometers.info/cn/)实时动态数据也还不错，但没做年度报表，那么就让我帮他写一个吧。

### 遇到三个主要问题

**跨语言快速上手例子的选择上**

[51cto-静态网页爬虫①](https://blog.51cto.com/u_15743016/5549456)，倒是给我启发还蛮大的，因为网上搜的例子稍较复杂，基础例子又太过“敷衍”了。从它的给出例子，再看看[BS官方文档](https://beautifulsoup.cn)、[selenium官方文档](https://selenium-python-zh.readthedocs.io/en/latest/index.html)，代码编写与调试的起步就舒服多了。

**获取网站动态内容的延迟问题**

在requests与time.sleep配合依旧是“获取数据中”的状态，那就以慢制慢咯，反爬也随缘处理，使用 webUI自动化来解决了。还有参考了[cnblogs -（数据科学学习手札50）基于Python的网络数据采集-selenium篇（上）](https://www.cnblogs.com/feffery/p/9570171.html)、[csdn-基于python爬虫—静态页面和动态页面爬取](https://blog.csdn.net/qq_52661119/article/details/119854694)也是让我选择webUI自动化的原因。

![](https://s2.xptou.com/2023/04/27/6449cac7b4486.png)

**下标数据存在重复项及其解决方案选取问题**

"Abortions this year"的中文项span class索引52存在重复的问题，英文版没有；但也存在其他class值选取上的难点。根据代码运行测试观察发现，只要做个标记值用`if continue`就好了。至于其他xlsx、csv追加、拼接、文件合并，调试起来有些麻烦，尤其是在Mac上，难说vb行不行得通，对于我来说不太适用，自己也不大喜这偏方。

注意源码的`current_population_words = soup.find_all('span',class_='item')`与 `if continue` 部分

简中版

![](https://s2.xptou.com/2023/04/27/6449c6c2606f7.png)

原版

![](https://s2.xptou.com/2023/04/27/6449c770d6430.png)



### 跨语言的综合感受

个人方面，跨语言有时语法搞混，实际上跟你切macOS/win10 UI及快捷键有点类似，一般都是用到才拿出来，适应一小段时间就好了。通常来说，备手基础文档，然后就是一个例子之类的，之后再结合自己的想法，接下来就是，如何去变通与实现了。

写python爬虫和shell/batch自动化，算是两个不同方向吧。一个偏web浏览器，涉及html/css/js 之类，以及网络应用层等方面的知识；另一个偏向系统软件、存储文件属性这方面吧。说难度吧，shell/batch好方便入手，其实也是看谁方便用谁，明确知道自己想要什么，就行。但往深了走，实际上没什么行业又是不难的。

