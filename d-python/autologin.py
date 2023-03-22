from DrissionPage import ChromiumPage
from selenium import webdriver
from DrissionPage import Drission, MixPage

# pip3 install selenium
# pip3 install DrissionPage
# Mac的路径问题：
# https://github.com/g1879/DrissionPage/issues/2

# 用 selenium 原生代码创建 WebDriver 对象
driver = webdriver.Chrome()
# 把 WebDriver 对象传入 Drission 对象
dr = Drission(driver_or_options=driver)
page = MixPage(drission=dr)

# 跳转到登录页面
page.get('http://10.10.10.1/ac_portal/default/pc.html?tabs=pwd')

# 定位到账号文本框并输入账号
page.ele('#password_name').input('user01')
# 定位到密码文本框并输入密码
page.ele('#password_pwd').input('2020')

# 记住登录状态
page.ele('#rememberPwd').click()

# 点击登录按钮
page.ele('#password_submitBtn').click()

# input("程序运行结束，可以按任意键退出")


# 参考

## DrissionPage 入门指南
### http://g1879.gitee.io/drissionpagedocs/3_get_start/1_installation_and_import/#_3
## DrissionPage 示例
### http://g1879.gitee.io/drissionpagedocs/9_demos/login_gitee/#_1
