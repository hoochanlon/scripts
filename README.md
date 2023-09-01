## 免责声明：所有内容仅面向信息研究、学习交流等，正常合规化使用。谢谢。

## 前言

项目涉及跨学科信息化综合应用与分析：桌面基线排查、软件激活破解、免杀及特权执行、渗透式支援固件识别读写、主机账户密码空值检测、Wi-Fi密码扫描、云主机终端安全加固、主机系统日志分析、自然语言处理、人文社科信息数据分析等。

* 系统平台：Windows/Mac/Linux；脚本语言：多种、不限；我流，按需编写。 
* 研究对象：基础信息自动化、云主机/本地桌面安全处理、社会科学信息化及数据分析。

项目代码涉及到部分组件版本兼容问题 <a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/平台兼容问题.ipynb">点击此处</a>；关于ipynb无法在GitHub进行预览，[请查看这里](https://blog.reviewnb.com/jupyter-notebook-not-rendering-on-github/)；生成自动化信息处理报表内容，可查阅 [d-xlsx](./d-xlsx) 目录了解详情。

## 常见平台热搜与辟谣信息分析

对人文社科期刊、论文研究对象进行跨学科、基础调研（不限于同事访谈、网络论坛问卷调查）等综合性分析。

* html网页解析、webui自动化
* 数据收集、过滤、分类归档
* "平均/极值"基础数学统计、分词、文本情绪值计算汇总（自然语言处理）

<details>
<summary>初上手时的基础操作，简单收集信息测试。</summary>

<p>一键获取中国新闻网资讯 <a href="https://www.52pojie.cn/thread-1780608-1-1.html">图文版</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_chinanews.py)"
</code></pre>

<p>一键获取中国新闻网资讯 Ruby版</p>

<pre><code>ruby -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-ruby/get_chinanews.rb)"
</code></pre>

<p>一键生成全球信息报表 <a href="https://www.52pojie.cn/thread-1779165-1-1.html">图文版</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_worldometers.py)"
</code></pre>

<p>一键收集知乎前五条精选回答摘要</p>
<pre><code>python3 -c "$(curl -fsSL https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/zhihu_answers_demo.py)"</code></pre>

<p>收集boss直聘90条招聘相关招聘岗位的薪资待遇、公司规模等 <a href="https://www.52pojie.cn/thread-1822212-1-1.html">图文版</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/zhipin_demo.py)"</code></pre>

</details>

<details>
<summary>平台热搜与辟谣信息汇总分析</summary>

前提：开始前，先复制如下指令安装 pip 工具包。涉及到斯坦福大学语言模型 [stanza](https://stanfordnlp.github.io/stanza) 处理的数据需要外网连接。

<pre><code>pip3 install --no-cache-dir -r https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-txt/requirements.txt
</code></pre>

<h3>头条、抖音、微博热搜采集分析</h3>

<p>一键获取今日头条、抖音、微博热搜。<a href="https://www.52pojie.cn/thread-1785460-1-1.html">图文版</a> （NLP：Stanza）</p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_resou_today_s.py)"
</code></pre>

<ul>
<li>自动化分类；整体匹配率：84%~96% 区间左右。</li>
<li>词频统计；三者共存的热搜，说明为持久公共热度，信息密度较高。</li>
<li>文本情感平均值、每条标题的情感数值；主：人为置顶热搜的文本情绪强烈程度。</li>
<li>词性分析；标记可能存有引导与被植入意识成分用词，只要定语、状语叠得多，总能是宣传正态形势。</li>
</ul>

<p>微博在自动化分类中，噪音三者最大，信息价值低，话题含水量大，失真度偏高；各家平台的热搜标题也存有未标识谣言成分，最好用<a href="https://www.piyao.org.cn/pysjk/frontsql.htm">国家辟谣平台查询</a>鉴别其真伪；虽然娱乐属性极重，但微博其本身具有一对多公共属性的社交模式，当某个社会事件被挂上热搜，它可在短时间内迅速传播信息，引发公众的关注和讨论。</p>

<p>推荐论文：</p>

<ul>
<li>毛贺祺《大数据背景下微博热搜的新闻阅读服务功能》吉林大学新闻学专业硕士学位论文，2017.3</li>
<li>喻国明《大数据分析下的中国社会舆情 总体态势与结构性特征》中国人民大学学报，2013年第５期</li>
<li>王小新《当前我国受众网络新闻的阅读倾向——以百度热搜词为例》《今传媒》，2013年第9期</li>
<li>许诺《基于百度热搜新闻词的社会风险事件5W提取研究》《系统工程理论与实践》，2022年第40卷第2期</li>
</ul>

<h3>自动化收集辟谣条目及语言分析</h3>

<p>功能大体与上例相当，对词频的较高词语进行语法分析。（NLP：ThuLAC）</p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_rumor_analysis.py)"
</code></pre>

<p>urllib3：<a href="https://github.com/urllib3/urllib3/issues/3020#issuecomment-1557412175">https://github.com/urllib3/urllib3/issues/3020#issuecomment-1557412175</a></p>

<p>对谣言的定义：阿尔波特（Gordom W.Allport）和波兹曼（Leo Postman）最早为谣言下了定义，即谣言是一个与当时事件相关联的命题，是为了使人相信，一般以口传媒介的方式在人们之间流传，但是却缺乏具体的资料以证实其确切性。<span id="fn1"><a href="#fn1-black"><sup>1</sup></a></span></p>

<p>谣言概念界定：究其本质而言，谣言普遍具有的属性，一是广泛传播，二是不确定性，基于此，本文将谣言界定为被广泛传播的、含有极大的不确定性的信息。“不确定性”主要是指对信息真实与否的不确定性。<span id="fn2"><a href="#fn2-black"><sup>2</sup></a></span></p>

<p>目前，在突发事件中的各类谣言中，有明确目标性和破坏性的攻击型谣言和以实现政治、经济等利益为目标的宣传型或牟利型谣言出现的频率较低。多数谣言是出于恐惧心理和基于错误的认识判断而形成的。（胡琦，2022） 从这次的谣言收集分析已证明，最大的两个类别是，社会话题与健康饮食，两者分别占比48%、43%。</p>

<p>但“后真相”时代多元文化的糅合共存和碎片化的解读方式加剧了民众的价值分歧，侵蚀了信任防线。一方面，复杂的利益诉求、多元的社会思潮与多样的传播方式交织叠加，催生出“后真相”时代多元的网络文化，加大了主流与非主流文化之间的碰撞和摩擦。虽然非主流文化是主流文化的有益补充，但诸如佛系文化、网红文化、躺平文化等难免有背离主流文化的消极因素，尤其是污丑文化、拜金文化等更是尽显畸形审美和金钱至上的错误思想，若不加警惕和批判，极易误导一些认知不足、阅历不够的受众，诱发政治偏见，不断冲击和侵蚀业已形成的政治信任。另一方面，“后真相”时代人们面对海量信息，惯以碎片化的方式拼凑事实、解读真相。一旦关涉社会分化、利益分配、政治腐败和政策失误等复杂的政治谣言鉴别，人们极易陷入碎片化信息的不断解读和重组,制造出多种“真相”,并借此持续发酵,非但无益于阻断网络政治谣言的传播，反而会频繁质疑已有政治共识,造成政治信任的流失，为谣言惑众创设了可能。<span id="fn3"><a href="#fn3-black"><sup>3</sup></a></span></p>

<p>就参考杨芸伊、赵惜群来说，个人生活无非涉及钱的吃穿住行，社会分化也是正常现象，“个人-集体”、“集体-个人”的差异、非一致性，这话更多“是以国家建设为中心”为首纲。下面这两条信息很值得参考研究：</p>

<ul>
<li><a href="https://www.zhihu.com/question/587740721/answer/2952171143">知乎 - 如何看待央视新视频【靠力气赚钱心里才踏实，是无数平凡人的生活信仰】?</a></li>
<li><a href="https://www.bilibili.com/video/BV1ss4y1M72E">bilibili - 说我摸，说我摆，谁在意劳动者的无奈？</a></li>
</ul>

<i><b>参考文献</b></i><br><br>
<span id="fn1-black"><a href="#fn1">[1]</a> 胡琦, 全媒体时代网络谣言产生的心理机制与治理路径,P135，137, [J]社会科学家, 2022(11)</span><br>
<span id="fn2-black"><a href="#fn2">[2]</a> 雷霞, 老年群体的谣言认知不协调及其纠偏机制, [J]现代传播, 2023(3)</span><br>
<span id="fn3-black"><a href="#fn3">[3]</a> 杨芸伊, 赵惜群, “后真相”时代网络政治谣言的表征、归因及治理,P155, [J]湖南科技大学学报(社会科学版)，2022(11)</span><br>

</details>

## B站用户评论、弹幕调研

脚本功能如下：

1. 视频标题、作者、发布时间、播放量、收藏量、分享量、累计弹幕、评论数、视频简介、视频类别、视频链接、封面链接。
1. 100条弹幕、情绪值、词性分析、发表时间、用户ID
1. 20篇热门评论、点赞数、情绪值、话题回复条目、会员ID、会员名、评论时间。
1. 威力增强：弹幕：用户名、生日、注册时间、粉丝数、关注数（cookie）；评论：显示评论用户的IP归属地（webbui）。
1. 最后生成xlsx，文本情绪值中位数、词频统计、词云、柱形统计图。

<details>
<summary>点击详情</summary>

前提：先确保你的基础库组件完善

<pre><code>pip3 install --no-cache-dir -r https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-txt/requirements.txt
</code></pre>

然后运行该脚本 <a href="https://www.52pojie.cn/thread-1802357-1-1.html">图文版</a>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_bv_baseinfo.py)"
</code></pre>

<h3>文本基础分析 </h3>

停用词文本聚类综合统计分析，见下图<span id="fn4"><a href="#fn4-black"><sup>1</sup></a></span>

<img src="https://cdn.jsdelivr.net/gh/hoochanlon/scripts/AQUICK/catch2023-06-27%2011.00.31.png" />

<p>实际上，不同的停用词表都有其的适用范围。教育机构语料库大多由文献期刊构成，因此复旦、川大等教育科研机构的停用词表，更适合文献与邮件文本。而门户网站的语料库更适合新闻报道，各有其特点。</p>

<p>文本发掘及分词统计涉及到的停用词问题，借助 [goto456/stopwords](https://github.com/goto456/stopwords) 提供的哈工大、川大、百度的停用词语料库，以及从CSDN收集到复旦停用词本进行整合，强化文本对“经济”、“社会”、“文艺”聚类效果，从而达到更精准命中关键词的目的。</p>

文本分析工作内容，如下引用图<span id="fn5"><a href="#fn5-black"><sup>2</sup></a></span>。目的性都差不多，只不过方式略有不同而已，殊途同归了，算是。

<img src="https://cdn.jsdelivr.net/gh/hoochanlon/scripts/AQUICK/catch2023-06-17%2019.25.52.png" />

<i><b>参考文献</b></i><br><br>
<span id="fn4-black"><a href="#fn4">[1]</a> 黄俊, 职场辱虐的情绪影响和行为反应研究、B站等社交媒体的传播研究,P149,[J]传播创新研究, 2021(12)</span><br>
<span id="fn5-black"><a href="#fn5">[2]</a> 官琴, 邓三鸿, 王昊, 中文文本聚类常用停用词表对比研究,P76,[J]数据分析与知识发现,2017(3) </span><br>
</details>

## 社会学选题对象基础研究 

该部分集中于互联网新闻传媒与网络社群组织动员分析。

<details>
<summary>点击详情</summary>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/亚文化视域评论及弹幕调研.ipynb">亚文化视域评论及弹幕调研总结</a></h4>

<p>整体来说，后情感时代，让我发现人的情感体验是多元的。单从就“嗑CP”、“萌宠”话题的被采访人语录来看，就得出部分被采访人思维单一、理想化。这是不可靠的，不能一概而论。比较切实的观点应该是，部分被采访人对此类信息可能并不在意，或对这方面未有较深入的认知与关注。并且，该项数据并不能对采访人的情绪、思维、行为逻辑做定论，只是某些事物的关联，需要去理清事情的真相与内在逻辑，这些都要花时间下功夫研究的。</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/民生及时评类新闻基础分析.ipynb">民生及时评类新闻媒体与受众行为浅析</a></h4>

<h5>民生时评媒体积极方面行为作用</h5>

<p>在单向度的社会<span id="fn6"><sup><a href="#fn6-black">1</a></sup></span>中，不同地域的人往往面临着相似的生活困境与社会纠纷，经由媒体选择典型民生个例加以报道，很容易使民众获得切身体会，产生跨地域的情感共鸣。而在此基础上的时评，遵守实事求是的原则，通过解释报道框架<span id="fn7"><sup><a href="#fn7-black">2</a></sup></span>，对各类舆论热点事件进行科学理性的分析，同时提出面向未来的可行性建设性方案。从一定程度上缓释社会矛盾，疏导大众情绪，有促进开启民智的作用。不过，额外强调一点：开启民智目是民众具备批判性思维，自主思考和客观分析问题；它强调的是社会共同进步的需要，而不是贬低民众的智识水平及行为能力。</p>

<h5>民生时评类新闻受众失焦现象归因</h5>

<p>一方面受众因切身体会共鸣感、猎奇感等作用下接收民生、时评信息，而另一方面身处风险社会<span id="fn8"><sup><a href="#fn8-black">3</a></sup></span>中、受众对严肃内容产生了排斥心理，需要一个可供闲谈与娱乐的话题排解忧虑，获得快感、同时也在探求相同爱好的趣缘群体。由此，这也可以解释我之前的疑问 “为什么我看同事日常精干处理工作事务，但涉及到电视剧、新闻报道却是人云亦云没多少见解，像个白痴一样？” 总的说来，舆论失焦现象也是必然且常态的现象。用户对新闻标题的猎奇点击，对事件的耐心等待与深入思考已不符合这方面一部分受众用户的期望了。在注意力、精力有限的情况下，这部分受众用户从而转向其他具有话题性、娱乐性的闲谈讨论，爆米花式的休闲娱乐（吃瓜）以此舒缓压力获得快感。</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/“小粉红”群体分析.ipynb">“小粉红”群体分析</a></h4>

<p>“小粉红”一词来自于民间对网络爱国青年群体的称呼，“小”指的是年龄小，虽然很稚嫩，但是精力充沛、一腔热血；“粉”指的是网络上流行的特有的表达方式，比如语言卖萌，又经常使用各种萌系表情，另外由于小，单纯的生活阅历使得“小粉红”的心智还没有定型；“红”指的是苗正根红，红色在中国的语境下通常代表了中国共产党，这里的“红”表达了“小粉红”强烈的爱党爱国爱领袖情怀。<span id="fn9"><sup><a href="#fn9-black">4</a></sup></span></p>

<p>刘芳对小粉红群体的定义是准确的。她进一步将该群体细分为不同的年龄段、社会阶层以及职业背景。在18至24岁的范围内，学生群体在小粉红中占据了很大比例，其中多数来自无产阶级家庭。然而，在旧牛帆模型流行之前的分类中，也有相当数量的小粉红来自城市中产阶级家庭，这一点也需要我们注意。无论如何，这两个群体都有一个共同点，即小粉红拥有较强的社会消费能力和购买力，并且相对承受较少的社会压力，同时也是中国改革开放国力日益强盛的受益者与见证者。</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/读《“帝吧出征”事件中话语表达与社群动员研究》.ipynb">读《“帝吧出征”事件中话语表达与社群动员研究》</a></h4>

<h5>帝吧出征：群体动员与舆论引导</h5>

<p>当群体的文化与他们倡导的价值目标重合时，形成了一种动力机制，促使群体成员对帝吧社群的多角度文化认同和集体互动。帝吧通过整齐划一的动员基础，深刻影响了其群体成员的价值观念和思维方式，从而调动了粉丝的积极性和团结性来支持社群的集体活动。</p>

<p>在网络平台上，民族主义情感的表达成为一种常见现象。通过共享符号、行为和与同样认同的人建立联系，人们表达对国家和民族的认同和情感。这种身份政治的表演受到个体和外部环境的相互作用和影响。在"周子瑜事件"中，帝吧充分利用网络的连通性，在各平台上刷榜和引流，通过构建共同的"爱国主义"和"民族主义"话语，动员和征集参与者。虽然"帝吧出征"看起来组织有序，参与者需服从指挥，有明确的出征时间、纪律和攻击目标，还要求使用固定的集体模板等规则。然而，实际上年轻人受到帝吧新式话语的影响和动员，不一定需要深入思考逻辑或进行论证，将出征变成了一场狂欢喧闹的游戏，追求集体热情高涨的情境。在这个动员过程中，明星相关的表情包渲染气氛，通过将明星与民族主义情感相结合，进一步加强集体认同和动员效果，激发粉丝的情感共鸣，并增强他们对集体行动的支持和参与意愿。</p>

<p>因此，“帝吧出征”可以被看作是一种集体动员和舆论引导的活动，通过符号、话语和情感的共同作用，调动粉丝的参与和支持，从而形成一种极化的群体行动力量。这种行动将网络暴力赋予了“民族主义”和“爱国主义”的正义化形象，使其在群体中得到广泛的接受和支持。</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/读《数字原住民网络潜水动因实证研究》.ipynb">读《数字原住民网络潜水动因实证研究》</a></h4>

<h5>研究目的及意义</h5>

<p>研究目的（微观）：</p>
<ol>
<li>界定潜水者和数字原住民型潜水者消除对于潜水的模糊定义。</li>
<li>构建潜水动因模型提出各项解释数字原住民潜水行为的动因假设。</li>
<li>明确主要影响因素以及因素之间的相互影响关系。</li>
<li>为网络运营商和社区管理者提供更有效的建议。 </li>
</ol>
<p>研究意义（宏观）：</p>
<p>一、理论意义：梳理社会学、经济学和心理学三大学科中用于潜水研究的相关理论并搭建了潜水研究的理论框架为后续研究者的相关研究提供了理论支撑。
二、实际意义：对于数字原住民潜水行为研究的实际意义主要体现在经济效益、网络可持续发展以及群体智慧三方面。</p>

<h5>基于“计划行为论”、“社会文化资本论”、“社会认同论”三者，并结合统计学知识的问卷设计方案</h5>

<p>问卷设计样例效果图<span id="fn10"><sup><a href="#fn9-black">5</a></sup></span> </p> 

<img src="https://cdn.jsdelivr.net/gh/hoochanlon/scripts/AQUICK/catch2023-07-19%2020.01.22.png" width="50%" height="50%"/>

<ul>
<li>信度分析：主要是考察各潜变量的Cronbach&#39;sa值是否超过0.7的临界值。</li>
<li>效度分析，主要基于因子分析来检验。也就是通过对样本数据进行KMO系数分析。Kaiser给出了常用的kmo度量标准:　0.9以上表示非常适合；0.8表示适合；0.7表示一般；0.6表示不太适合；0.5以下表示极不适合。</li>
<li>因子相关性分析：Bartlett球形检验则用于检验观测变量之间是否存在相关性，这是进行因子分析的一个前提条件。它基于一个假设，即观测变量之间不存在任何相关性。如果在Bartlett球形检验中得出的显著性水平较低（通常设置为0.05），则可以拒绝该假设，表明观测变量之间存在相关性，因此适合进行因子分析。</li>
<li>偏向程度分析：Likert量表的评分范围为5或7个等级，但也可以是其他数字。选择适当的评分范围要考虑到被调查者容易理解和回答的程度。较少的等级可能更容易导致患者在选择中立选项时受到限制，而较多的等级可能增加了患者选择的复杂性。</li>
</ul>

</details>

解疑探索分析：

1. How many government officials read Marx and how many believe in Marx?
2. 对就业进行个人与企业，以及相关欺诈案例进行全面分析

<details>
<summary>点击详情</summary>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/读《论马克思主义威望下降的原因》.ipynb">读《论马克思主义威望下降的原因》</a></h4>

<p>马克思主义威望下降的原因：</p>

<p>消极因素：1. 苏联式社会主义制度失败的打击；2. 部分共产党官员和马克思主义理论家的言行相悖严重损害了马克思主义的声誉；3. 不少人对于马克思主义不大懂、不会用，不能解决实际问题；4. 一些人对马克思学说的否定也起了一定作用。</p>

<p>积极因素：1. 从横向上看，改革开放开阔了我们的思想理论视野，使马克思主义的相对地位下降；2. 从纵向上看，我们创造出中国特色社会主义理论等新的理论，也使马克思主义的相对重要性减弱；3. 人们现在愈来愈能够对马克思学说采取科学分析的态度，亦使马克思主义的威望从顶峰回落。</p>

<h4 id="h3view"><a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/就业形势分析及预防欺诈对策.ipynb">就业形势分析及预防欺诈对策</a></h4>

<h4>欺诈者的动机内核</h4>

<p>我们的视野里已经有太多的宏大叙事与情绪感慨，欠缺的反而是“事实本身” 。现如今较起之前好了不少，当时信息传播渠道有限，仅限于搜索引擎、门户网站，如今信息。人人自媒体，民意重视程度相对比过去要高了。但伴随而来的又一个问题就是审核控评，结合我国当今体制及制度而言，整体不容乐观。总体而言，我们的认知是建立在他们代价付出与信息披露。</p>

从刘莫鲜（2012）<span id="fn11"><sup><a href="#fn11-black">6</a></sup></span>所述的各类手法的诈骗流程图分析，来对双方目的进行总结：欺诈者的目的存在一个或多个，拿到货币、人身控制、获得劳动力；而求职者目的相对单一，付出劳动力，拿到货币。值得注意的是，欺诈者、求职者都是为了拿到对方的货币，由此便产生了不完全信息的零和博弈。

由于欺诈者的目的及偏好多样化，可选择的策略空间广，选择取向也相对较多，因此欺诈者会穷尽所有可能，并且不择手段地来实现自身利益最大化。因此，欺诈者的核心策略是在特定的环境和场景下，在求职者付出劳动之前或之后，以获取劳动者的货币为目标。

<h4>欺诈者对求职者的信念构建及欺诈实施</h4>

<p>对于欺诈者来说，能不能骗到求职者是一个概率性问题。求职者来自各个不同的生活环境，其行为选择对于欺诈者来说是不能预测的。不过，这里必须要明确一个关键点：既然骗子能够骗得到人，那么被骗到的人是那些相信他不是骗子的人。换句话说，欺诈者之所以能骗到求职者，关键是因为建立起了求职者的信任。虽然我们每个人的行为选择不可预测，但骗子能够利用各种手段来营造特定的稀缺情景，以建立对求职者的信任。借着这种信任，他们可以进行有限条件的选择，从而实现对求职者意图行为的控制。</p>

<p>具体来说，欺诈者常常利用社会心理学来布设博弈困境以及相应的剧本演出，以便操控求职者的思维和情绪。他们通常宣称有限的职位名额、紧迫的截止日期、特殊服务后门或其他形式的稀缺性，以激发求职者的竞争心理和渴望，促使求职者尽快做出决策。通过在这种紧张的情景中建立信任，此时欺诈者为了进一步验证求职者的“诚意”及“合作性”，这时欺诈者会要求求职者提供个人信息，支付一定费用或执行某些任务。这些要求看似合理，但实际上是为了获取求职者的敏感信息或从其身上获取经济利益。</p>

</details>

<p><b>参考文献</b></p>

<!--<p><i>注：由于研究范围较广泛，部分专题涉及内容较深，因此采用 ipynb 独立开题综述具体内容，并放置相关链接的形式。故此处参考文献列表仅限于 README.Markdown</i></p>-->

<span id="fn6-black"><a href="#fn6">[1]</a> <a href="http://www.rmlt.com.cn/2014/0729/298965.shtml">范晓丽, 李超, “单向度的人”及其对当代中国的启示,[M]人民论坛网, 2014(7)</a><br></span>
<span id="fn7-black"><a href="#fn7">[2]</a> <a href="http://media.people.com.cn/n/2015/0312/c150620-26682877.html">李煜申, 邢天意, 新闻网站报道的媒介框架差异分析 ——基于人民网等四家新闻网站的“8.3鲁甸地震事故”再现对比研究, [M]人民网研究院,2015(03) </a><br>
<span id="fn8-black"><a href="#fn8">[3]</a> <a href="http://www.xml-data.org/KXYSH/html/22ddadf4-325e-41ce-b447-82a9129abf51.htm">张文霞, 赵延东, 风险社会：概念的提出及研究进展, [M]知网协办, 2011(1)</a><br>
<span id="fn9-black"><a href="#fn9">[4]</a> 刘芳,“小粉红”社会责任承担的现实考量与提升路径研究,P9-13, [M]湖南大学硕士学位论文,2019</span><br>
<span id="fn10-black"><a href="#fn10">[5]</a> 刘江,数字原住民网络潜水动因实证研究,P69, [M]南京大学硕士学位论文,2013</span><br>
<span id="fn11-black"><a href="#fn11">[6]</a> 刘莫鲜,在虚假招聘的背后——对大学生求职受騙现象的质性探究,P61-83, [M]南京大学博士学位论文,2012</span><br>


## Windows桌面技术基线检查 

首先，确保你的系统已开启 PowerShell

* **打开PowerShell功能：`Set-ExecutionPolicy RemoteSigned`**
* ***关闭PowerShell功能：`Set-ExecutionPolicy Restricted`***

<details>
<summary><b>点击详情</b></summary>

一键使用，本地下载使用转GB2312编码 <a href="https://www.52pojie.cn/thread-1795749-1-1.html">图文版</a>

<pre><code>
irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-pwsh/frontline_helpdesk.ps1|iex
</code></pre>

功能概览：

<ol>
<li>检查IP与网络设备连接近况</li>
<li>检查打印机、打印池、扫描仪状态</li>
<li>检查硬盘、CPU、内存、显卡等基础驱动信息</li>
<li>检查设备安全性、近期升级补丁、定时任务项、证书策略、系统核心文件控制访问状况</li>
<li>检查主机主动共享协议相关信息</li>
<li>检查电脑休眠、重启频次、异常关机、程序崩溃等信息</li>
<li>执行1～6选项的所有功能</li>
<li>生成"设备驱动检查"、"五天内预警事件"、"登录登出活动记录"、"月度已存威胁概况"分析报表</li>
<li>查看指导建议与开发说明</li>
</ol>

BTW

Linux基线检查（PR）见：<a href="https://github.com/al0ne/LinuxCheck">al0ne/LinuxCheck</a>。对于Mac来说，这些安全服务的维护成本，不适用于中小企业。

<ul>
<li><a href="https://www.apple.com.cn/business/docs/site/Mac_Deployment_Overview.pdf">Apple - Mac系统部署</a></li>
<li><a href="https://blogs.vmware.com/china/2019/10/08/企业采购苹果设备的正确姿势-abm/">vmware - 企业采购苹果设备的正确姿势-abm</a></li>
</ul>

大环境下，这篇文章 <a href="https://blog.csdn.net/smartbenson/article/details/50636012">CSDN - 企业管理Mac电脑的三种方式</a>提及的管理办法，都算得上是防控得当，可对比Windows来说，却挺不够看的。

</details>

## Mac基础终端操控知会

想要自由使用Mac步骤：

1. **允许所有来源： `sudo spctl --master-disable`**
2. **恢复模式下，关闭SIP：`csrutil disable`**
3. **解除苹果签名验证系统的校验隔离：`sudo xattr -d com.apple.quarantine`**
4. **运行终端工具包前提 —— homebrew，复制如下指令安装**

```
/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
```

<details>
<summary><b>点击详情</b></summary>

关闭Safari浏览器的腾讯安全浏览

<pre><code>
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool false
</code></pre>

重置macOS ~/.zshrc （仅环境变量配置失误，造成不可逆后果使用）

<pre><code>
export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin; sudo rm -rf ~/.zshrc
</code></pre>


Mac查看当前Wi-Fi密码 <a href="https://www.52pojie.cn/thread-1766927-1-1.html">图文版</a>

<pre><code>
sudo bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/mac_show_wifi.sh)"
</code></pre>

Mac查看常用系统信息

<pre><code>
sudo bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/mac_systeminfo.sh)"
</code></pre>

GitHub的ipynb文件地址 转换 在线ipynb查看链接粘贴。（Ruby）

<pre><code>
ruby -e "$(wget -qO- https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-ruby/nbview.rb)"
</code></pre>

Mac 一键支持NTFS <a href="https://github.com/hoochanlon/Free-NTFS-For-Mac">图文版</a>

<pre><code>
sudo -u $USER  python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/mac_ntfs_ninja.py)"
</code></pre>

Mac 激活各类相关软件 <a href="https://github.com/QiuChenly/MyMacsAppCrack/tree/main/Shells">图文版</a>（DMCA）

<pre><code>
sudo bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/QiuChenly/MyMacsAppCrack/main/Shells/simple_crack.sh)"
</code></pre>

macOS MS-AutoUpdate 一键带走

<pre><code>
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-apple/no_ms_autoupdate.scpt)"
</code></pre>

一键RAR密码爆破 <a href="https://www.52pojie.cn/thread-1775990-1-1.html">图文版</a>

<pre><code>
bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/7z_rar_sensei.sh)"
</code></pre>

自动化下载 Office Mac2021 激活工具

<pre><code>
sudo /usr/bin/osascript -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-apple/office2021.scpt)"
</code></pre>

最后，转朋友的：<a href="https://www.cnblogs.com/98record/p/mac-da-yin-ji-yi-jian-an-zhuang.html">自在拉基 - Mac打印机一键安装</a>。（没需求，所以没写；原理都差不多，确实挺厉害的。）

</details>

## Linux云主机毛坯房安全改造

购买云服务商提供的云主机，系统基本没有任何的安全软件保护。每天都有各地不法分子扫描公网，并不断远程暴破、入侵主机。所以需要采取防治措施。

<details>
<summary><b>点击详情</b></summary>

<h3>一键搞定SSH登录、用户密码策略配置、Ban IP配置 <a href="https://www.52pojie.cn/thread-1749877-1-1.html">图文版</a></h3>

<ul>
<li>SSH登录: 免密的密钥模式、心跳长时间连接，客户端不掉线</li>
<li>密码策略: 不限特殊字符、大小写，并支持4～5位长度下限</li>
<li>Ban IP: 除自己IP外，30秒内短时间三次输错密码，永久封禁IP。</li>
</ul>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/lite_ssh_n_ban.sh)"
</code></pre>

<p>SSH单项配置：一键调用SSH快速配置 SSH密钥登录策略、用户简单密码配置规则。（单项部分是开启限定自己IP访问的，即 AllowUsers）</p>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/simple_ssh.sh)"
</code></pre>

<p>fail2ban单项配置：一键fail2ban从下载到安装及生成配置与启动服务。(再次允许单项部分可以刷新自己公网IP配置)</p>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/simple_ban.sh)"
</code></pre>

<h3>一键搞定Linux自定义创建具有管理员权限的用户 <a href="https://www.52pojie.cn/thread-1749877-1-1.html">图文版</a></h3>

<ul>
<li>自定义用户名</li>
<li>su、sudo及wheel组成员免密</li>
<li>sshd_config锁root远程登录，提高安全性</li>
</ul>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/diy_add_wheel.sh)"
</code></pre>

<h3>一键搞定FTP <a href="https://www.52pojie.cn/thread-1753070-1-1.html">图文版</a></h3>

<ul>
<li>共享目录： /var/ftp/share </li>
<li>限制越权出逃共享访问，可读写。</li>
<li>安全，私有化，限定自己的公网IP访问。</li>
</ul>

<p>不输密码版，用户名:ftpuser 密码：P@ssw0rd</p>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/simple_vsftpd.sh)"
</code></pre>

<p>自定义用户版</p>

<pre><code>
sudo bash -c  "$(curl -fL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/lite_vsftpd.sh)"
</code></pre>

</details>

## 企业基础环境需求

主要涉及：

* IE、Windows defender、Windows更新、Flash & Chrome v87、钉钉静默安装、打印机自动化安装
* 文件校验工具：MD5、SHA1、SHA256 哈希值计算、比较、校验工具。
* C盘空间释放：钉钉、微信、Foxmail本地缓存、Windows.old、Windows升级日志、文件等一键清理工作（C盘灭霸脚本）。
* 应聘岗位基础技能、IQ 与 EQ 测评、薪资范围选定汇总及需求分析。

<details>
<summary><b>点击详情</b></summary>

<p>IE防Edge劫持 <a href="https://www.52pojie.cn/thread-1774349-1-1.html">图文版</a></p>

<pre><code>curl -L  https://ghproxy.com/https://github.com/hoochanlon/scripts/raw/main/d-bat/keep_ie.bat|cmd</code></pre>

<ul>
<li>注【1】：<a href="https://www.52pojie.cn/thread-1765347-1-1.html">域控环境IE模版 图文</a></li>
<li>注【2】：代码地址：<a href="https://github.com/hoochanlon/scripts/blob/main/d-bat/saigonoie.bat">https://github.com/hoochanlon/scripts/blob/main/d-bat/saigonoie.bat</a></li>
</ul>

<p>计算IE兼容视图网站hex，一键使用，本地下载使用转GB2312编码。</p>

<pre><code>
irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-pwsh/clac_ie_clearablelistdata_hex.ps1|iex
</code></pre>

<p>一键永久关闭Windows更新设置 <a href="https://www.52pojie.cn/thread-1791338-1-1.html">图文版</a></p>

<pre><code>curl -L  https://ghproxy.com/https://github.com/hoochanlon/scripts/raw/main/d-bat/stop_update.bat|cmd</code></pre>

<p>一键恢复被关闭的Windows更新设置</p>

<pre><code>curl -L  https://ghproxy.com/https://github.com/hoochanlon/scripts/raw/main/d-bat/re_update.bat|cmd</code></pre>

<p>一键开启或关闭Windows defender实时保护</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/choice_wdrt.bat&&call choice_wdrt.bat</code></pre>

<p>C盘灭霸脚本：钉钉、微信、Foxmail本地缓存、Windows.old、Windows升级日志、文件等一键清理工作</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/mieba.bat&&call mieba.bat</code></pre>

<p>一键调用设置程序是否以管理员权限运行</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/nano_runas.bat&&call nano_runas.bat</code></pre>

<p>去掉win10/win11热搜条目（需注销或重启） <a href="https://admx.help/?Category=Windows_8.1_2012R2&Policy=Microsoft.Policies.WindowsExplorer::DisableSearchBoxSuggestions&Language=zh-cn">admx.help 上见</a></p>

<pre><code>reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f</code></pre>

<p>一键调用md5、sha1、sha256文件检测工具</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/md5tools.bat&&call md5tools.bat</code></pre>

<p>一键安装flash以及配置支持的87版Chrome浏览器</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/fxxk_chxxa.bat&&call fxxk_chxxa.bat</code></pre>

<p>一键安装禁止Chrome浏览器更新</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/deny_chrome_update.bat&&call deny_chrome_update.bat</code></pre>

<p>一键PDFtoPNG</p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/PDFtoPNG.py)"</code></pre>

<p>一键修复共享打印机0x11b问题</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/fix_0x11b_share_print.bat&&call fix_0x11b_share_print.bat</code></pre>

<p>一键获取招聘职位信息以及辅助资料参考网站</p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/zhipin_demo.py)"</code></pre>

<p> 安装指定chrome，并禁用升级：<a href="https://github.com/hoochanlon/scripts/blob/main/d-bat/only_install_chrome65.bat"> only_install_chrome65.bat </a>;钉钉静默安装源码： <a href="./d-bat/fuck_dingding.bat">fuck_dingding.bat</a>；打印机安装详情见：<a href="https://nbviewer.org/github/hoochanlon/scripts/blob/main/d-ipynb/打印机自动化安装研究.ipynb">打印机自动化安装研究.ipynb</a></p>

</details>

## 壁纸设定

一面工作，一面生活。

<ol>
<li>ruby 必须在3.0以上版本</li>
<li>ruby 在Windows平台融入性，一体化程度不如Linux/macOS。</li>
<li>通过此次ruby抓图及文本处理，ruby支持的功能库远不如python，适用基础简单的爬虫操作。</li>
<li>基于国内网络环境考量，不做原生写入处理，改用aira2下载，以便监控进度。</li>
</ol>

<details>
<summary><b>点击详情</b></summary>

<p>一键爬取bing壁纸 <a href="https://www.52pojie.cn/thread-1781868-1-1.html">图文版</a></p>

<pre><code>python3 -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-python/get_bing_wallpapers.py)"</code></pre>

<p>一键下载微软官方设计壁纸 ruby </p>

<pre><code>ruby -e "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-ruby/get_msdesign_wallpapers.rb)"</code></pre>

<p>一键定时切换壁纸，一面工作，一面生活（Mac）</p>

<pre><code>bash -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-shell/mac_corn_diy_wallpaper.sh)"</code></pre>

</details>

## 移花接木与细枝末节

这部分都是自己发现好玩的，根据不少参考网上资料的文章、源码、神Key，结合自己的思考分析，而做的二创改写，并加工成调用指令。

* Windows/Office、winrar、emeditor、idm、XchangePDF
* Wi-Fi、PE查看局域网IP、解析主机IP运营商及归属地查询
* 其他更多...

<details>
<summary><b>点击查看详情</b></summary>

<h3>移花接木</h3>

<p>CMD一键调用windows版本切换与Windows/Office激活 <a href="https://www.52pojie.cn/thread-1743122-1-1.html">图文版</a></p>

<pre><code>curl -O https://ghproxy.com/https://raw.githubusercontent.com/TerryHuangHD/Windows10-VersionSwitcher/master/Switch.bat&amp;&amp;TIMEOUT /T 1&&start Switch.bat&&powershell -command "irm https://massgrave.dev/get|iex"</code></pre>

<p>CMD一键安装winrar注册激活</p>

<pre><code>powershell -command Invoke-WebRequest -Uri "https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/winrar_down_reg.bat" -OutFile "C:/Users/${env:UserName}/Downloads/winrar_down_reg.bat"&&TIMEOUT /T 1&&start /b C:\Users%username%\Downloads\winrar_down_reg.bat
</code></pre>

<p>Powershell一键生成Emeditor序列号</p>

<pre><code>irm https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-pwsh/emeditor_random_keygen.ps1|iex
</code></pre>

<p>Powershell一键IDM激活（<a href="https://github.com/hoochanlon/scripts/blob/main/d-pwsh/fail_idm.ps1">自己写的方案已失效，国内版权原因不做更新</a>）</p>

<pre><code>iwr -useb https://ghproxy.com/https://raw.githubusercontent.com/lstprjct/IDM-Activation-Script/main/IAS.ps1 | iex
</code></pre>

<p>Powershell从XchangePDF Editor下载安装到生成许可证</p>

<pre><code>curl https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-pwsh/xchange_v8_active.ps1 -Outfile xchange_v8_active.ps1 | powershell -c xchange_v8_active.ps1
</code></pre>

<p>win7 打开图片报错“内存不足” <a href="https://www.52pojie.cn/thread-1768841-1-1.html">图文版</a></p>

<pre><code>powershell -c "irm  https://ghproxy.com/https://github.com/hoochanlon/scripts/raw/main/d-bat/exifhelper.bat -Outfile exifhelper.bat" && exifhelper.bat
</code></pre>

<h3>细枝末节</h3>

<p>CMD获取本机公网详情</p>

<pre><code>powershell -c irm "https://freeipapi.com/api/json/$(irm http://api.ipify.org)"
</code></pre>

<p>Shell获取本机公网详情（需安装 <code>brew install jq</code>）</p>

<pre><code>curl -s https://freeipapi.com/api/json/$(curl -s https://api.ipify.org) | jq .
</code></pre>

<p>一键安装打印机原理代码 <a href="https://www.52pojie.cn/thread-1776328-1-1.html">图文版</a></p>

<pre><code>https://github.com/hoochanlon/scripts/blob/main/d-bat/install_public_network_hp_printer_driver.bat
</code></pre>

<p>powershell active，以及微PE显示IP脚本</p>

<pre><code>explorer https://github.com/hoochanlon/scripts/blob/main/d-bat/weipe_showip.bat
</code></pre>

<p>一键安装Java <a href="https://www.52pojie.cn/thread-1767872-1-1.html">图文版</a></p>

<pre><code>curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/install_jdk.bat&amp;&amp;call install_jdk.bat
</code></pre>

<p>win11一键显示当前WiFi与密码并生成二维码分享 <a href="https://www.52pojie.cn/thread-1772481-1-1.html">图文版</a></p>

<pre><code>curl -O https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/show_wifi.bat&amp;&amp;call show_wifi.bat
</code></pre>

<p>一键显示所有WiFi</p>

<pre><code>curl -OfsSL https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/oh_my_wifi.bat&amp;&amp;call oh_my_wifi.bat
</code></pre>

<p>一键RAR密码爆破 <a href="https://www.52pojie.cn/thread-1775357-1-1.html">图文版</a></p>

<pre><code>curl -Os https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-bat/seven_z_sensei.bat&amp;&amp;call seven_z_sensei.bat
</code></pre>

</details>

---
***谢谢观赏，附 [Latex Demo](https://www.overleaf.com/read/khdnbtjxwkzx) ，以飨同好。***

<!--
[![telegram](https://img.shields.io/badge/telegram-:me-blue.svg?longCache=true&style=flat-square)](https://t.me/test) 

![ ](https://raw.githubusercontent.com/hoochanlon/hoochanlon/master/assets/github-contribution-grid-snake.svg)

[网络辟谣标签工作专区](https://www.piyao.org.cn/bq/index.htm)、[谣言曝光台](https://www.piyao.org.cn/yybgt/index.htm)

***[关于我](https://hoochanlon.github.io/hoochanlon)***

[![blog](https://img.shields.io/badge/%F0%9F%94%97blog-hoochanlon-lightgrey.svg?longCache=true&style=flat-square)](https://hoochanlon.github.io/) [![outlook](https://img.shields.io/badge/%F0%9F%93%A7hotmail-@邮箱联系-blue.svg?longCache=true&style=flat-square)](mailto:hoochanlon@outlook.com)[![](https://img.shields.io/github/followers/hoochanlon?color=green&style=social)](https://github.com/hoochanlon) [![](https://img.shields.io/github/stars/hoochanlon?color=green&style=social)](https://github.com/hoochanlon)

![Metrics](https://metrics.lecoq.io/hoochanlon?template=classic&base.header=0&base.activity=0&base.community=0&base.repositories=0&base.metadata=0&achievements=1&base=header%2C%20activity%2C%20community%2C%20repositories%2C%20metadata&base.indepth=false&base.hireable=false&base.skip=false&achievements=false&achievements.threshold=S&achievements.secrets=true&achievements.display=detailed&achievements.limit=0&config.timezone=Asia%2FShanghai)

-->



<!--

-->
