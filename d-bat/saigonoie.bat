@REM ------------- 特权升级与关闭UAC---------------------------

@REM [csdn-让bat批处理以管理员权限运行的实现方法](https://blog.csdn.net/NeiHan2020/article/details/124982175)
@REM 让bat启动时，首先调用vbs脚本，通过vbs脚本，以管理员身份调用该bat的 runas 部分，最后顺便定位脚本当前执行环境（目录）

@ECHO off
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

@REM 关闭UAC，重启生效
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

@REM ----------- 兼容性视图 ----------------------------

@REM 将所有网站都加入兼容性视图。
@REM [cnblogs-注册表法修改IE8安全级别的方法](https://www.cnblogs.com/freeton/p/3675018.html)
@REM 在国内的环境，要求使用IE浏览器，索性全都统一设置成兼容视图吧
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation" /v "AllSitesCompatibilityMode" /t REG_DWORD /d 1 /f

@REM -------- 主页设置与防劫持 --------------------------
@REM  最新的win11系统已经把IE的主页设置GUI移除了。

@REM 设置主页
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d www.baidu.com /f

@REM 防止主页不被恶意修改，原理：外来程序没有这么高的权限修改这一项。
@REM reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul
@REM 该指令用于解除死锁！ >nul 不输入任何信息。
@REM reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul

@REM 防止 edge 劫持 IE ，即IE默认启用第三方扩展。
@REM [[REG]「サード パーティ製のブラウザー拡張を許可する」をレジストリで設定する方法【IE11編】](https://automationlabo.com/wat/?p=4213)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f

@REM 注册表修改，但不关闭IE默认启用第三方扩展。(最新版的win10/11系统还是得关掉IE默认启用的第三方扩展...双管齐下)
@REM https://techcommunity.microsoft.com/t5/enterprise/ie-to-edge-87-redirection-issues/m-p/1941961
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

@REM ------------- 加入可信任站点 -----------------

@REM /v参数后面是“http”，这意味着它将创建或修改名为“http”的键值对；/t 指定type /d  指定设置或修改的注册表项的值； /f 强制
@REM 由于 Ranges\Range100 都是数字，还要配置两次冗长的键值注册，个人感觉不如 ZoneMap\Domains 好管理。
@REM 添加网址并指定为可信任战点。0x00000002为2的十六进制。

@REM 这里会存在信任站点GUI界面删除不了IP站点的bug，即使用示例中的另一方法也是如此，所以最好设置为与IE浏览器相关的业务
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.1" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.2" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.3" /v https /t REG_DWORD /d 0x00000002 /f

@REM 有域名的网站倒是可以正常删除，IP的就只能用注册表删除了。
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\baidu.com\www" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\bing.com\www" /v https /t REG_DWORD /d 0x00000002 /f


@REM ----------------- IE受信任的站点设置，逐条解读---------------------------

@REM 直接将可信任战点的安全级别调至最低
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 

@REM 直接将Intranet 内部网的安全级别调至最低
@REM 0 本地计算机区域；1 Intranet 内部网； 2 受信任的站点区域；3 Internet 外网域；4 受限制的站点区域。
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 

@REM [51cto-使用域组策略设置IE受信任站点](https://blog.51cto.com/guozhengyuan/1393631)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "Flags" /t REG_DWORD /d 0x00047 /f

@REM 将IE配置策略应用到所有用户。 在win11的IE上出现不能加入可信任站点的bug
@REM https://www.itprotoday.com/compute-engines/jsi-tip-5130-how-can-i-manage-internet-explorer-security-zones-registry
@REM reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v SECURITY_HKLM_ONLY /t REG_DWORD /d 1 /f

@REM 各项配置及模版查阅：
:: https://admx.help/?Category=InternetExplorer&Policy=Microsoft.Policies.InternetExplorer::IZ_Policy_TurnOnProtectedMode_9&Language=zh-cn
:: https://admx.help/?Category=InternetExplorer&Policy=Microsoft.Policies.InternetExplorer::IZ_PolicyTrustedSitesZoneTemplate&Language=zh-cn

@REM 启用ActiveX 控件自动提示，0，启用；3，禁用。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f

@REM 0，启用；1，禁用；2，提示。启用 Java 小程序脚本 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1402" /t REG_DWORD /d 0 /f

@REM 0，启用; 启用下载已签名的 ActiveX 控件 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f

@REM 3，禁用；禁用下载未签名的 ActiveX 控件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 1 /f

@REM 选项只能跟着文档走，可能是工程量太大了，所有数字选项不统一，比较凌乱。
@REM 继续.....

@REM 禁用仅允许经过批准的域在未经提示的情况下使用 ActiveX 控件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120B" /t REG_DWORD /d 0 /f

@REM 禁用使用弹出窗口阻止程序
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1809" /t REG_DWORD /d 3 /f

@REM 启用允许 Internet Explorer WebBrowser 控件的脚本
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1206" /t REG_DWORD /d 0 /f

@REM 启用允许 META REFRESH，允许重定向
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1608" /t REG_DWORD /d 0 /f

@REM 启用允许 Scriptlet，网页验证码用得着
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1209" /t REG_DWORD /d 0 /f

@REM 启用允许二进制文件和脚本行为
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2000" /t REG_DWORD /d 0 /f

@REM 允许加载 XAML 文件，提供了对动画和3D众多方面的支持。
:: [百度百科-XAML](https://baike.baidu.com/item/XAML/6123952?fr=aladdin)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2402" /t REG_DWORD /d 0 /f

@REM 启用允许加载 XAML 浏览器应用程序
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2400" /t REG_DWORD /d 0 /f

@REM 启用允许加载 XPS 文件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2401" /t REG_DWORD /d 0 /f

@REM 启用允许在一个窗口中拖动不同域中的内容，**禁用**
@REM 防止员工，乱拖动导致错点选项。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2708" /t REG_DWORD /d 3 /f

@REM 启用允许在多个窗口之间拖动不同域中的内容，**禁用**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2709" /t REG_DWORD /d 3 /f

@REM 允许在网页上使用旧媒体播放机播放视频和动画，**禁用**
@REM 防止员工看视频，摸鱼
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120A" /t REG_DWORD /d 3 /f

@REM 允许字体下载
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1604" /t REG_DWORD /d 0 /f

@REM 允许安装桌面项目，它可以让用户将 Web 内容作为桌面背景 **提示** 。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1800" /t REG_DWORD /d 1 /f

@REM 允许拖放文件或复制/粘贴文件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1802" /t REG_DWORD /d 0 /f

@REM 允许文件下载
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1803" /t REG_DWORD /d 0 /f

@REM 允许活动脚本；禁用则会阻止运行该区域中页面上的脚本代码。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1400" /t REG_DWORD /d 0 /f

@REM 允许由脚本启动的窗口，不受大小或位置限制 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2102" /t REG_DWORD /d 0 /f

@REM 允许网站使用脚本窗口提示获得信息
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2105" /t REG_DWORD /d 0 /f

@REM 允许网站打开没有状态栏或地址栏的窗口
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2104" /t REG_DWORD /d 0 /f

@REM 允许通过受限制的协议的活动内容访问我的电脑，**提示** 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2300" /t REG_DWORD /d 1 /f

@REM 允许通过脚本从剪贴板进行剪切、复制或粘贴操作
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1407" /t REG_DWORD /d 0 /f

@REM 允许通过脚本更新状态栏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2103" /t REG_DWORD /d 0 /f

@REM 关闭 .NET Framework 安装程序， **禁用**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2600" /t REG_DWORD /d 0 /f

@REM 关闭首次运行控件提示
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1208" /t REG_DWORD /d 0 /f

@REM 启用 MIME 探查，主要用来确认文件类型。
:: [Java获取文件的Mime类型的几种方式总结](https://backend.devrank.cn/traffic-information/7082116610194065421)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2100" /t REG_DWORD /d 0 /f

@REM 启用 SmartScreen 筛选器扫描，**禁用**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2301" /t REG_DWORD /d 3 /f

@REM 禁用保护模式
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2500" /t REG_DWORD /d 3 /f

@REM 启用跨站点脚本筛选，**禁用**
@REM 允许跨站点脚本注入。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1409" /t REG_DWORD /d 3 /f

@REM 启用Internet Explorer 呈现旧版筛选器。做兼容的
:: https://learn.microsoft.com/en-us/archive/blogs/ie_cn/ie10-release-preview-dx
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270B" /t REG_DWORD /d 0 /f

@REM 启用在IFRAME中启动应用程序和文件
@REM FRAME是HTML标签，作用是文档中的文档，或者浮动的框架(FRAME)。iframe元素会创建包含另外一个文档的内联框架（即行内框架）。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1804" /t REG_DWORD /d 0 /f

@REM 在不太严格的 Web 内容域中的网站可以导航到此区域，**提示**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2101" /t REG_DWORD /d 1 /f

@REM 启用对可能不安全的文件显示安全警告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1806" /t REG_DWORD /d 0 /f

@REM 启用对标记为可安全执行脚本的 ActiveX 控件执行脚本，无须用户干预即可自动进行脚本交互。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f

@REM 对没有标记为安全的 ActiveX 控件进行初始化和脚本运行，**提示**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 1 /f

@REM 用户数据持久化
@REM 用户可以在浏览器历史记录、收藏夹、XML 存储或直接在保存到磁盘的网页中保存信息。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1606" /t REG_DWORD /d 0 /f

@REM 允许提交非加密表单数据
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1601" /t REG_DWORD /d 0 /f

@REM 启用文件下载的自动提示
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2200" /t REG_DWORD /d 0 /f

:: 显示混合内容，**提示** 安全(https://)和不安全内容(http://)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1609" /t REG_DWORD /d 1 /f

@REM 启用“没有证书或只有一个证书时不提示进行客户端证书选择”
@REM 对可信任站点，自动证书确认
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A04" /t REG_DWORD /d 0 /f

@REM 用户通过 HTML 表单上载文件时发送路径信息。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "160A" /t REG_DWORD /d 0 /f

@REM 自动使用当前用户名和密码自动登录
@REM 网络上的smb文件共享
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A00" /t REG_DWORD /d 0 /f

@REM 启用此策略设置，则 Internet Explorer 不会检查反恶意程序，以查看是否可安全创建 ActiveX 控件实例。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270C" /t REG_DWORD /d 0 /f

@REM 用户可以跨域打开窗口和框架，并可以跨域访问应用程序。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1607" /t REG_DWORD /d 0 /f

@REM REG_DWORD 的默认进制是十六进制，它的数值可以用十进制、二进制方式来表示。
@REM 196608 十进制，软件频道权限，安全级 - 低 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1E05" /t REG_DWORD /d 0x030000 /f

@REM 启用运行 ActiveX 控件和插件
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f

@REM 启用执行未签名的托管组件。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2004" /t REG_DWORD /d 0 /f
@REM 启用执行签名的托管组件。
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2001" /t REG_DWORD /d 0 /f

@REM 用户可以在区域中加载使用 MSXML 或 ADO 访问区域中其他站点数据的页面
@REM 内部数据库访问
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1406" /t REG_DWORD /d 0 /f

@REM Java 权限，安全级 - 低；196608 十进制
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1C00" /t REG_DWORD /d 0x030000 /f

@REM 保留字部分，如： Default1408Local、Default140ATrusted、Default1605Internet、Default2302Restricted

:: 起先查阅的资料:[csdn-修改注册表来修改IE的设置资料汇总](https://blog.csdn.net/wangqiulin123456/article/details/17068649)
:: 微软官方已将旧版的IE文档资料删除了，不过还是找到了蛛丝马迹。对比如下两个文档，可以发现其端倪。
:: 估摸着微软当时是想做些什么设置，然后在"受信任的站点区域模板"板块，对这些保留项做了别有意味的定义
:: https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/c05dc3bf-dcfc-4f46-8be2-8a78e46875a7

@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "140A" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1605" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1408" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2302" /t REG_DWORD /d 0 /f


@REM ------------ 兼容性视图示例。----------------
@REM %Temp% 是一个变量目录，双击winRAR的运行文件常保存在这
@REM  [新浪爱问知识达人-attrib -s -r -h是什么意思？](https://iask.sina.com.cn/b/3124185.html)
@REM  attrib更改单个文件或目录的属性，R只读属性 -R清除只读属性；H设置隐藏属性；S设置系统属性。
@REM  del /f：强制删除只读文件。/s：删除所有子目录中的指定的文件。/q：安静模式

@REM If exist "%Temp%\~import.reg" (
@REM  Attrib -R -S -H "%Temp%\~import.reg"
@REM  del /F /Q "%Temp%\~import.reg"
@REM If exist "%Temp%\~import.reg" (
@REM  Echo Could not delete file "%Temp%\~import.reg"
@REM  Pause
@REM )

@REM 从 Internet Explorer\BrowserEmulation\ClearableListData\UserFilter 导入注册表的用法。
@REM [IE浏览器兼容性视图设置数据解析](https://blog.csdn.net/thb_cn/article/details/125124565)
@REM 该文章虽说描述细致，但二进制、十六进制并不适合大多数人，故PASS
@REM 而且这样的做法，易导致IE 兼容性视图设置无法添加网站，提示“你输入了一个无效域”的错误
:: [cnblogs-IE 11兼容性视图设置无法添加网站，提示“你输入了一个无效域”](https://www.cnblogs.com/xiykj/p/13603024.html)

@REM > "%Temp%\~import.reg" ECHO Windows Registry Editor Version 5.00
@REM >> "%Temp%\~import.reg" ECHO.
@REM >> "%Temp%\~import.reg" ECHO [HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData]
@REM >> "%Temp%\~import.reg" ECHO "UserFilter"=hex:41,1f,00,00,53,08,ad,ba,01,00,00,00,36,00,00,00,01,00,00,00,\
@REM >> "%Temp%\~import.reg" ECHO   01,00,00,00,0c,00,00,00,d9,1c,6d,08,94,d9,d6,01,01,00,00,00,0c,00,31,00,39,\
@REM >> "%Temp%\~import.reg" ECHO   00,32,00,2e,00,31,00,36,00,38,00,2e,00,30,00,2e,00,33,00,33,00

@REM START /WAIT REGEDIT /S "%Temp%\~import.reg"
@REM DEL "%Temp%\~import.reg"


@REM ------- 加入可信任站点示例 ------------------------

@REM 可信任站点设置，改写成你自己需要设置的网址及地址 Range是分支范围的意思，每添加一个域名，Range1...2...3等等
@REM “:Range”是这个特定范围的名称。请注意，名称前面的冒号是必需的，虽然是字符串键值，但以示区分同名关系。
@REM REG_SZ 字符串类型；REG_DWORD 数值类型；将该项分支指定到受信任领域
@REM 0 本地计算机区域；1 Intranet 内部网； 2 受信任的站点区域；3 Internet 外网域；4 受限制的站点区域。

@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range100" /v ":Range" /t REG_SZ /d 192.168.0.11 /f 
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range100" /v "http" /t REG_DWORD /d 2 /f

@REM -----------写代码涉及到的工具---------------------

@REM 写好的批处理可以用 Bat To Exe Converter打包成exe文件
@REM Windows设置重要的参考网站：https://admx.help
@REM 注册表工具：https://registry-finder.com
@REM 搜索工具：https://www.voidtools.com/zh-cn/
@REM 小鱼儿win11 IE修复工具：https://www.yrxitong.com/h-nd-963.html

ECHO "已关闭UAC，重启电脑将生效。"
pause
