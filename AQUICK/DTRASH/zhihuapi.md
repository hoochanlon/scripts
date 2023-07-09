# 知乎API分析

回答者基本信息

```
https://www.zhihu.com/api/v4/members/zong-you-diao-min-xiang-hai-zhen-1-58-56?include=allow_message%2Cis_followed%2Cis_following%2Cis_org%2Cis_blocking%2Cemployments%2Canswer_count%2Cfollower_count%2Carticles_count%2Cgender%2Cbadge%5B%3F%28type%3Dbest_answerer%29%5D.topics
```

关联问题

```
https://www.zhihu.com/api/v4/questions/562083816/similar-questions?include=data%5B*%5D.answer_count%2Cauthor%2Cfollower_count&limit=5&answer_id=3
```

回答

```
https://www.zhihu.com/api/v4/questions/562083816/feeds?cursor=377cfc0f521fa6e6ca782136cd937fe6&include=data%5B%2A%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Creaction_instruction%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%3Bdata%5B%2A%5D.mark_infos%5B%2A%5D.url%3Bdata%5B%2A%5D.author.follower_count%2Cvip_info%2Cbadge%5B%2A%5D.topics%3Bdata%5B%2A%5D.settings.table_of_content.enabled&limit=5&offset=0&order=default&platform=desktop&session_id=1688828905373224118
```

```
https://www.zhihu.com/api/v4/questions/562083816/feeds?page=3&session_id=1688854656455617606
```

[知乎，爬虫，x-zse-86 2.0](https://www.victue.com/2021/03/30/zhihu_answer/)，从这文中得知，知乎做了加密处理。阅读其他文章了解加密内容：

* [cnblogs - 知乎加密参数x-zse-96详解](https://www.cnblogs.com/xiaowangba9494/p/15934907.html)
* [知乎 - 分析 分析 知乎加密算法 最新 x-zse-96](https://zhuanlan.zhihu.com/p/419576219)
* [csdn -2021年6月知乎指定问题信息爬取 & x-zse-96 2.0版本加密破解分析 爬虫破解反扒思路](https://blog.csdn.net/qq_26394845/article/details/118183245)
* [思否 - 某乎搜索接口zse96参数逆向分析【2022.11版本】](https://segmentfault.com/a/1190000042751896)
* [52pojie - 某乎x-zse-96签名算法python重写(出处: 吾爱破解论坛)](https://www.52pojie.cn/thread-1631378-1-1.html)

npm idealTree:lib: sill idealTree buildDeps

* [csdn - 设置npm源的几种方式](https://blog.csdn.net/u010856177/article/details/126851940)
* [ERROR:Node Sass version 7.0.1 is incompatible with ^4.0.0.](https://www.cnblogs.com/Merrys/p/16905691.html)


