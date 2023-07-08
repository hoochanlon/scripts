# 知乎API分析

回答者基本信息

```
https://www.zhihu.com/api/v4/members/zong-you-diao-min-xiang-hai-zhen-1-58-56?include=allow_message%2Cis_followed%2Cis_following%2Cis_org%2Cis_blocking%2Cemployments%2Canswer_count%2Cfollower_count%2Carticles_count%2Cgender%2Cbadge%5B%3F%28type%3Dbest_answerer%29%5D.topics
```

json

```json
{
    "id": "ce9e9d8294ad09d71d136e18bf827188",
    "url_token": "zong-you-diao-min-xiang-hai-zhen-1-58-56",
    "name": "总有刁民想害朕",
    "use_default_avatar": false,
    "avatar_url": "https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=32738c0c",
    "avatar_url_template": "https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff.jpg?source=32738c0c",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/api/v4/people/zong-you-diao-min-xiang-hai-zhen-1-58-56",
    "user_type": "people",
    "headline": "这是一个到处都是杠精的社会。",
    "headline_render": "这是一个到处都是杠精的社会。",
    "gender": -1,
    "is_advertiser": false,
    "ip_info": "IP 属地江苏",
    "vip_info": {
        "is_vip": false,
        "vip_type": 0,
        "rename_days": "0",
        "entrance_v2": null,
        "rename_frequency": 0,
        "rename_await_days": 0
    },
    "badge": [],
    "badge_v2": {
        "title": "",
        "merged_badges": [],
        "detail_badges": [],
        "icon": "",
        "night_icon": ""
    },
    "allow_message": true,
    "is_following": false,
    "is_followed": false,
    "is_blocking": false,
    "follower_count": 7484,
    "answer_count": 487,
    "articles_count": 71,
    "available_medals_count": 0,
    "employments": [],
    "is_realname": true,
    "has_applying_column": false
}
```
关联问题

```
https://www.zhihu.com/api/v4/questions/562083816/similar-questions?include=data%5B*%5D.answer_count%2Cauthor%2Cfollower_count&limit=5&answer_id=3
```

Json

```
{
    "paging": {
        "is_end": true,
        "is_start": true,
        "next": "https://www.zhihu.com/api/v4/questions/562083816/similar-questions?answer_id=3\u0026include=data%5B%2A%5D.answer_count%2Cauthor%2Cfollower_count\u0026limit=10\u0026offset=10",
        "previous": "https://www.zhihu.com/api/v4/questions/562083816/similar-questions?answer_id=3\u0026include=data%5B%2A%5D.answer_count%2Cauthor%2Cfollower_count\u0026limit=10\u0026offset=0",
        "totals": 4
    },
    "data": [
        {
            "type": "question",
            "id": 569033658,
            "title": "为什么新一代的年轻人越来越拒绝生孩子？",
            "question_type": "normal",
            "created": 1669478775,
            "updated_time": 1669478775,
            "url": "https://www.zhihu.com/api/v4/questions/569033658",
            "answer_count": 96,
            "comment_count": 0,
            "follower_count": 99,
            "relationship": {}
        },
        {
            "type": "question",
            "id": 571496899,
            "title": "现在的年轻人为什么不敢生孩子？",
            "question_type": "normal",
            "created": 1670623003,
            "updated_time": 1670623004,
            "url": "https://www.zhihu.com/api/v4/questions/571496899",
            "answer_count": 3,
            "comment_count": 0,
            "follower_count": 7,
            "relationship": {}
        },
        {
            "type": "question",
            "id": 569684967,
            "title": "为什么现在的年轻人都不愿生孩子？",
            "question_type": "normal",
            "created": 1669751178,
            "updated_time": 1669751178,
            "url": "https://www.zhihu.com/api/v4/questions/569684967",
            "answer_count": 6,
            "comment_count": 0,
            "follower_count": 7,
            "relationship": {}
        },
        {
            "type": "question",
            "id": 501359848,
            "title": "现在的年轻人为什么都不愿生孩子了？",
            "question_type": "normal",
            "created": 1637761810,
            "updated_time": 1637761810,
            "url": "https://www.zhihu.com/api/v4/questions/501359848",
            "answer_count": 21,
            "comment_count": 0,
            "follower_count": 29,
            "relationship": {}
        }
    ]
}
```

回答

```
https://www.zhihu.com/api/v4/questions/562083816/feeds?cursor=377cfc0f521fa6e6ca782136cd937fe6&include=data%5B%2A%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Creaction_instruction%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%3Bdata%5B%2A%5D.mark_infos%5B%2A%5D.url%3Bdata%5B%2A%5D.author.follower_count%2Cvip_info%2Cbadge%5B%2A%5D.topics%3Bdata%5B%2A%5D.settings.table_of_content.enabled&limit=5&offset=0&order=default&platform=desktop&session_id=1688828905373224118
```

json

```
{
    "data": [
        {
            "type": "question_feed_card",
            "target_type": "answer",
            "target": {
                "admin_closed_comment": false,
                "annotation_action": null,
                "answer_type": "normal",
                "attached_info": "ogEQCAQQAxjezYyACyDo74KMApICJQoJNTY2OTkzMTQyEgoyOTUyOTk2NTc0GAQiCklNQUdFX1RFWFQ=",
                "author": {
                    "avatar_url": "https://pic1.zhimg.com/v2-d41c2ceaed8f51999522f903672a521f_l.jpg?source=1940ef5c",
                    "avatar_url_template": "https://pica.zhimg.com/v2-d41c2ceaed8f51999522f903672a521f.jpg?source=1940ef5c",
                    "badge": [],
                    "badge_v2": {
                        "detail_badges": [],
                        "icon": "",
                        "merged_badges": [],
                        "night_icon": "",
                        "title": ""
                    },
                    "follower_count": 0,
                    "gender": 1,
                    "headline": "",
                    "id": "0",
                    "is_advertiser": false,
                    "is_blocked": false,
                    "is_blocking": false,
                    "is_celebrity": false,
                    "is_followed": false,
                    "is_following": false,
                    "is_org": false,
                    "is_privacy": false,
                    "name": "匿名用户",
                    "type": "people",
                    "url": "https://www.zhihu.com/api/v4/people/0",
                    "url_token": "",
                    "user_type": "people"
                },
                "can_comment": {
                    "reason": "",
                    "status": true
                },
                "collapse_reason": "",
                "collapsed_by": "nobody",
                "comment_count": 181,
                "comment_permission": "all",
                "content": "\u003cp data-pid=\"7DfG1NGe\"\u003e我是省会重点中学实验班班主任，以我的角度来看，大多数孩子真的太苦了，社会卷得家长，学校都对孩子疯狂PUA，孩子成了各方攫取利益的工具，每天晚睡早起卷题，出来工作又是一波996福报，大多数操劳一生命运根本不能掌控在自己手中，我只能尽我所能让班上的学生学习期间多一点人的尊严，其它无能为力……\u003c/p\u003e\u003cp data-pid=\"zy1QAT2U\"\u003e－－－－－－－\u003c/p\u003e\u003cp data-pid=\"eTTNhAsm\"\u003e非常有意思的是领导一边PUA暗示我要更拼更卷，一边自己也是人间清醒，一次饭局上某主任悄悄给我说可惜了他孩子不和我一届不然一定送到我班上，大家都想卷别人孩子，怕自己孩子卷……\u003c/p\u003e",
                "content_mark": {},
                "created_time": 1679731868,
                "decorative_labels": [],
                "editable_content": "",
                "excerpt": "我是省会重点中学实验班班主任，以我的角度来看，大多数孩子真的太苦了，社会卷得家长，学校都对孩子疯狂PUA，孩子成了各方攫取利益的工具，每天晚睡早起卷题，出来工作又是一波996福报，大多数操劳一生命运根本不能掌控在自己手中，我只能尽我所能让班上的学生学习期间多一点人的尊严，其它无能为力… －－－－－－－ 非常有意思的是领导一边PUA暗示我要更拼更卷，一边自己也是人间清醒，一次饭局上某主任悄悄给我说可惜了他…",
                "extras": "",
                "id": 2952996574,
                "is_collapsed": false,
                "is_copyable": false,
                "is_labeled": false,
                "is_mine": false,
                "is_normal": true,
                "is_sticky": false,
                "is_visible": true,
                "mark_infos": [],
                "question": {
                    "created": 1666662516,
                    "id": 562083816,
                    "question_type": "normal",
                    "relationship": {},
                    "title": "为什么现在的年轻人都拒绝生孩子？",
                    "type": "question",
                    "updated_time": 1666662516,
                    "url": "https://www.zhihu.com/api/v4/questions/562083816"
                },
                "reaction_instruction": {},
                "relationship": {
                    "is_author": false,
                    "is_authorized": false,
                    "is_nothelp": false,
                    "is_thanked": false,
                    "upvoted_followees": [],
                    "voting": 0
                },
                "relevant_info": {
                    "is_relevant": false,
                    "relevant_text": "",
                    "relevant_type": ""
                },
                "reshipment_settings": "disallowed",
                "reward_info": {
                    "can_open_reward": false,
                    "is_rewardable": false,
                    "reward_member_count": 0,
                    "reward_total_money": 0,
                    "tagline": ""
                },
                "settings": {
                    "table_of_contents": {
                        "enabled": false
                    }
                },
                "sticky_info": "",
                "suggest_edit": {
                    "reason": "",
                    "status": false,
                    "tip": "",
                    "title": "",
                    "unnormal_details": {
                        "description": "",
                        "note": "",
                        "reason": "",
                        "reason_id": 0,
                        "status": ""
                    },
                    "url": ""
                },
                "thanks_count": 444,
                "thumbnail_info": {
                    "count": 0,
                    "thumbnails": [],
                    "type": "thumbnail_info"
                },
                "type": "answer",
                "updated_time": 1679978793,
                "url": "https://www.zhihu.com/api/v4/answers/2952996574",
                "visible_only_to_author": false,
                "voteup_count": 2790,
                "zhi_plus_extra_info": ""
            },
            "skip_count": false,
            "position": 0,
            "cursor": "377cfc0f521fa6e63791fe35cd937fe6"
        },
        {
            "type": "question_feed_card",
            "target_type": "answer",
            "target": {
                "admin_closed_comment": false,
                "annotation_action": null,
                "answer_type": "normal",
                "attached_info": "ogEQCAQQAxjL3PDSCiDo74KMApICJQoJNTQ5NzUwMzQzEgoyODU4MTY3ODgzGAQiCklNQUdFX1RFWFQ=",
                "author": {
                    "avatar_url": "https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=1940ef5c",
                    "avatar_url_template": "https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff.jpg?source=1940ef5c",
                    "badge": [],
                    "badge_v2": {
                        "detail_badges": [],
                        "icon": "",
                        "merged_badges": [],
                        "night_icon": "",
                        "title": ""
                    },
                    "exposed_medal": {
                        "avatar_url": "",
                        "description": "",
                        "medal_id": "0",
                        "medal_name": ""
                    },
                    "follower_count": 30,
                    "gender": -1,
                    "headline": "",
                    "id": "c8ebeb7f443d10fdc57b11b9930acf1d",
                    "is_advertiser": false,
                    "is_followed": false,
                    "is_following": false,
                    "is_org": false,
                    "is_privacy": false,
                    "name": "积云层风摇",
                    "type": "people",
                    "url": "https://www.zhihu.com/api/v4/people/c8ebeb7f443d10fdc57b11b9930acf1d",
                    "url_token": "ji-yun-ceng-feng-yao",
                    "user_type": "people"
                },
                "can_comment": {
                    "reason": "",
                    "status": true
                },
                "collapse_reason": "",
                "collapsed_by": "nobody",
                "comment_count": 127,
                "comment_permission": "all",
                "content": "\u003cp data-pid=\"GyLdgIyu\"\u003e生活的面貌逐渐怪异\u003c/p\u003e\u003cp data-pid=\"giJ9C9tY\"\u003e我认为正常的生活应该是周一到周五正常上班8小时，下午到点就下班，没有任何人需要因为老板的脸色而被逼加班装作很上进的样子。在回家的路上路过菜市场，买点菜买点肉，快到家的时候闻闻邻居今晚吃什么，回到家做饭吃饭，然后到附近的公园散散步，看看大妈们跳广场舞，遛狗的遛狗，跑步的跑步，慢慢晃悠回到家洗个澡，看时间不到10点，还可以打打游戏看看书，然后睡个美美的觉第二天精神奕奕地去上班。\u003c/p\u003e\u003cp data-pid=\"hcz4mNc5\"\u003e从什么时候开始这样简单的生活变成一种奢侈？\u003c/p\u003e\u003cp data-pid=\"yQUc3AK1\"\u003e为什么我们要被迫加班装作很努力很上进实际上只是在浪费时间？\u003c/p\u003e\u003cp data-pid=\"D7dfYAYC\"\u003e为什么内卷成为主流，鼓吹奋斗是zzzq，躺下来休息就是不负责任虚度光阴？\u003c/p\u003e\u003cp data-pid=\"3NnCt8cP\"\u003e为什么婚姻和生育成为zb收割的肥羊，给所有人设下一个超高门槛的人生意义，有没有人问过这样的人生意义是不是自己喜欢的，发自内心追求的？\u003c/p\u003e\u003cp data-pid=\"nuDMFWrm\"\u003e当生活的面貌早已脱离我所期待的样子，为什么我还要带一个小生命来体验呢\u003c/p\u003e",
                "content_mark": {},
                "created_time": 1674541556,
                "decorative_labels": [],
                "editable_content": "",
                "excerpt": "生活的面貌逐渐怪异 我认为正常的生活应该是周一到周五正常上班8小时，下午到点就下班，没有任何人需要因为老板的脸色而被逼加班装作很上进的样子。在回家的路上路过菜市场，买点菜买点肉，快到家的时候闻闻邻居今晚吃什么，回到家做饭吃饭，然后到附近的公园散散步，看看大妈们跳广场舞，遛狗的遛狗，跑步的跑步，慢慢晃悠回到家洗个澡，看时间不到10点，还可以打打游戏看看书，然后睡个美美的觉第二天精神奕奕地去上班。 从什…",
                "extras": "",
                "id": 2858167883,
                "is_collapsed": false,
                "is_copyable": true,
                "is_labeled": false,
                "is_mine": false,
                "is_normal": true,
                "is_sticky": false,
                "is_visible": true,
                "mark_infos": [],
                "question": {
                    "created": 1666662516,
                    "id": 562083816,
                    "question_type": "normal",
                    "relationship": {},
                    "title": "为什么现在的年轻人都拒绝生孩子？",
                    "type": "question",
                    "updated_time": 1666662516,
                    "url": "https://www.zhihu.com/api/v4/questions/562083816"
                },
                "reaction_instruction": {},
                "relationship": {
                    "is_author": false,
                    "is_authorized": false,
                    "is_nothelp": false,
                    "is_thanked": false,
                    "upvoted_followees": [],
                    "voting": 0
                },
                "relevant_info": {
                    "is_relevant": false,
                    "relevant_text": "",
                    "relevant_type": ""
                },
                "reshipment_settings": "allowed",
                "reward_info": {
                    "can_open_reward": false,
                    "is_rewardable": false,
                    "reward_member_count": 0,
                    "reward_total_money": 0,
                    "tagline": ""
                },
                "settings": {
                    "table_of_contents": {
                        "enabled": false
                    }
                },
                "sticky_info": "",
                "suggest_edit": {
                    "reason": "",
                    "status": false,
                    "tip": "",
                    "title": "",
                    "unnormal_details": {
                        "description": "",
                        "note": "",
                        "reason": "",
                        "reason_id": 0,
                        "status": ""
                    },
                    "url": ""
                },
                "thanks_count": 412,
                "thumbnail_info": {
                    "count": 0,
                    "thumbnails": [],
                    "type": "thumbnail_info"
                },
                "type": "answer",
                "updated_time": 1674541556,
                "url": "https://www.zhihu.com/api/v4/answers/2858167883",
                "visible_only_to_author": false,
                "voteup_count": 2822,
                "zhi_plus_extra_info": ""
            },
            "skip_count": false,
            "position": 0,
            "cursor": "377cfc0f521fa6e686b7f134cd937fe6"
        },
        {
            "type": "question_feed_card",
            "target_type": "answer",
            "target": {
                "admin_closed_comment": false,
                "annotation_action": null,
                "answer_type": "normal",
                "attached_info": "ogEQCAQQAxjIpdrTCiDo74KMApICJQoJNTUwMDY0OTAwEgoyODU5ODk3NTQ0GAQiCklNQUdFX1RFWFQ=",
                "author": {
                    "avatar_url": "https://pica.zhimg.com/v2-42bfee399e38abb4d61f2cee8ef805e8_l.jpg?source=1940ef5c",
                    "avatar_url_template": "https://picx.zhimg.com/v2-42bfee399e38abb4d61f2cee8ef805e8.jpg?source=1940ef5c",
                    "badge": [],
                    "badge_v2": {
                        "detail_badges": [],
                        "icon": "",
                        "merged_badges": [],
                        "night_icon": "",
                        "title": ""
                    },
                    "exposed_medal": {
                        "avatar_url": "https://picx.zhimg.com/v2-7565d834d652a9960da0cedd8d7952ee_l.png?source=1940ef5c",
                        "description": "被 100 个人关注",
                        "medal_avatar_frame": "",
                        "medal_id": "972477022068568064",
                        "medal_name": "备受瞩目",
                        "mini_avatar_url": "https://picx.zhimg.com/v2-7565d834d652a9960da0cedd8d7952ee_r.png?source=1940ef5c"
                    },
                    "follower_count": 158,
                    "gender": -1,
                    "headline": "",
                    "id": "476433759ba60044851a5449e5f62349",
                    "is_advertiser": false,
                    "is_followed": false,
                    "is_following": false,
                    "is_org": false,
                    "is_privacy": false,
                    "name": "爱玩的喵星人",
                    "type": "people",
                    "url": "https://www.zhihu.com/api/v4/people/476433759ba60044851a5449e5f62349",
                    "url_token": "ai-wan-de-miao-xing-ren",
                    "user_type": "people"
                },
                "can_comment": {
                    "reason": "",
                    "status": true
                },
                "collapse_reason": "",
                "collapsed_by": "nobody",
                "comment_count": 180,
                "comment_permission": "all",
                "content": "\u003cp data-pid=\"u2O47YeB\"\u003e要是活的清醒点，就能发现。你人生的每件大事上都被人安装了铡刀，就等你到了然后砍一刀，不会让你死，但绝对会刮你一身皮。\u003c/p\u003e\u003cp class=\"ztext-empty-paragraph\"\u003e\u003cbr/\u003e\u003c/p\u003e\u003cp data-pid=\"Ph-YqXD4\"\u003e出生，上学，恋爱，结婚，生子，养老。这些阶段都被人为的设置了重重阻碍，好在你身上吸血。而这一长串的核心关节在哪儿呢？没错，就是生子，只要不生子，这条路的主动权就在你身上了。\u003c/p\u003e\u003cp class=\"ztext-empty-paragraph\"\u003e\u003cbr/\u003e\u003c/p\u003e\u003cp data-pid=\"72Ul7zqG\"\u003e总听人说十八层地狱啥的，谁又能确定人间不是地狱呢。\u003c/p\u003e",
                "content_mark": {},
                "created_time": 1674649651,
                "decorative_labels": [],
                "editable_content": "",
                "excerpt": "要是活的清醒点，就能发现。你人生的每件大事上都被人安装了铡刀，就等你到了然后砍一刀，不会让你死，但绝对会刮你一身皮。 出生，上学，恋爱，结婚，生子，养老。这些阶段都被人为的设置了重重阻碍，好在你身上吸血。而这一长串的核心关节在哪儿呢？没错，就是生子，只要不生子，这条路的主动权就在你身上了。 总听人说十八层地狱啥的，谁又能确定人间不是地狱呢。",
                "extras": "",
                "id": 2859897544,
                "is_collapsed": false,
                "is_copyable": true,
                "is_labeled": false,
                "is_mine": false,
                "is_normal": true,
                "is_sticky": false,
                "is_visible": true,
                "mark_infos": [],
                "question": {
                    "created": 1666662516,
                    "id": 562083816,
                    "question_type": "normal",
                    "relationship": {},
                    "title": "为什么现在的年轻人都拒绝生孩子？",
                    "type": "question",
                    "updated_time": 1666662516,
                    "url": "https://www.zhihu.com/api/v4/questions/562083816"
                },
                "reaction_instruction": {},
                "relationship": {
                    "is_author": false,
                    "is_authorized": false,
                    "is_nothelp": false,
                    "is_thanked": false,
                    "upvoted_followees": [],
                    "voting": 0
                },
                "relevant_info": {
                    "is_relevant": false,
                    "relevant_text": "",
                    "relevant_type": ""
                },
                "reshipment_settings": "allowed",
                "reward_info": {
                    "can_open_reward": false,
                    "is_rewardable": false,
                    "reward_member_count": 0,
                    "reward_total_money": 0,
                    "tagline": ""
                },
                "settings": {
                    "table_of_contents": {
                        "enabled": false
                    }
                },
                "sticky_info": "",
                "suggest_edit": {
                    "reason": "",
                    "status": false,
                    "tip": "",
                    "title": "",
                    "unnormal_details": {
                        "description": "",
                        "note": "",
                        "reason": "",
                        "reason_id": 0,
                        "status": ""
                    },
                    "url": ""
                },
                "thanks_count": 435,
                "thumbnail_info": {
                    "count": 0,
                    "thumbnails": [],
                    "type": "thumbnail_info"
                },
                "type": "answer",
                "updated_time": 1674649651,
                "url": "https://www.zhihu.com/api/v4/answers/2859897544",
                "visible_only_to_author": false,
                "voteup_count": 2638,
                "zhi_plus_extra_info": ""
            },
            "skip_count": false,
            "position": 0,
            "cursor": "377cfc0f521fa6e6c562fc34cd937fe6"
        },
        {
            "type": "question_feed_card",
            "target_type": "answer",
            "target": {
                "admin_closed_comment": false,
                "annotation_action": null,
                "answer_type": "normal",
                "attached_info": "ogEQCAQQAxibm9TSCiDo74KMApICJQoJNTQ5NjY1MzA1EgoyODU3NzAwNzYzGAQiCklNQUdFX1RFWFQ=",
                "author": {
                    "avatar_url": "https://picx.zhimg.com/v2-630c9408577247fe141acffa00abc513_l.jpg?source=1940ef5c",
                    "avatar_url_template": "https://picx.zhimg.com/v2-630c9408577247fe141acffa00abc513.jpg?source=1940ef5c",
                    "badge": [],
                    "badge_v2": {
                        "detail_badges": [],
                        "icon": "",
                        "merged_badges": [],
                        "night_icon": "",
                        "title": ""
                    },
                    "exposed_medal": {
                        "avatar_url": "",
                        "description": "",
                        "medal_id": "0",
                        "medal_name": ""
                    },
                    "follower_count": 560,
                    "gender": 1,
                    "headline": "以真理为师，与自由为友。",
                    "id": "60ce062aa858df62f061a246e61fa848",
                    "is_advertiser": false,
                    "is_followed": false,
                    "is_following": false,
                    "is_org": false,
                    "is_privacy": false,
                    "name": "俄亥俄级核潜艇",
                    "type": "people",
                    "url": "https://www.zhihu.com/api/v4/people/60ce062aa858df62f061a246e61fa848",
                    "url_token": "li-yun-dong-43-74",
                    "user_type": "people"
                },
                "can_comment": {
                    "reason": "",
                    "status": true
                },
                "collapse_reason": "",
                "collapsed_by": "nobody",
                "comment_count": 22,
                "comment_permission": "all",
                "content": "\u003cp data-pid=\"-HnUBMbv\"\u003e因为那一句话“孩子是他的软肋”啊！\u003c/p\u003e",
                "content_mark": {},
                "created_time": 1674507087,
                "decorative_labels": [],
                "editable_content": "",
                "excerpt": "因为那一句话“孩子是他的软肋”啊！",
                "extras": "",
                "id": 2857700763,
                "is_collapsed": false,
                "is_copyable": true,
                "is_labeled": false,
                "is_mine": false,
                "is_normal": true,
                "is_sticky": false,
                "is_visible": true,
                "mark_infos": [],
                "question": {
                    "created": 1666662516,
                    "id": 562083816,
                    "question_type": "normal",
                    "relationship": {},
                    "title": "为什么现在的年轻人都拒绝生孩子？",
                    "type": "question",
                    "updated_time": 1666662516,
                    "url": "https://www.zhihu.com/api/v4/questions/562083816"
                },
                "reaction_instruction": {},
                "relationship": {
                    "is_author": false,
                    "is_authorized": false,
                    "is_nothelp": false,
                    "is_thanked": false,
                    "upvoted_followees": [],
                    "voting": 0
                },
                "relevant_info": {
                    "is_relevant": false,
                    "relevant_text": "",
                    "relevant_type": ""
                },
                "reshipment_settings": "allowed",
                "reward_info": {
                    "can_open_reward": false,
                    "is_rewardable": false,
                    "reward_member_count": 0,
                    "reward_total_money": 0,
                    "tagline": ""
                },
                "settings": {
                    "table_of_contents": {
                        "enabled": false
                    }
                },
                "sticky_info": "",
                "suggest_edit": {
                    "reason": "",
                    "status": false,
                    "tip": "",
                    "title": "",
                    "unnormal_details": {
                        "description": "",
                        "note": "",
                        "reason": "",
                        "reason_id": 0,
                        "status": ""
                    },
                    "url": ""
                },
                "thanks_count": 316,
                "thumbnail_info": {
                    "count": 0,
                    "thumbnails": [],
                    "type": "thumbnail_info"
                },
                "type": "answer",
                "updated_time": 1674507087,
                "url": "https://www.zhihu.com/api/v4/answers/2857700763",
                "visible_only_to_author": false,
                "voteup_count": 2374,
                "zhi_plus_extra_info": ""
            },
            "skip_count": false,
            "position": 0,
            "cursor": "377cfc0f521fa6e6d80bf634cd937fe6"
        },
        {
            "type": "question_feed_card",
            "target_type": "answer",
            "target": {
                "admin_closed_comment": false,
                "annotation_action": null,
                "answer_type": "normal",
                "attached_info": "ogEQCAQQAxigvMPZCiDo74KMApICJQoJNTUyMjg0NDIxEgoyODcyMTA2NTI4GAQiCklNQUdFX1RFWFQ=",
                "author": {
                    "avatar_url": "https://pic1.zhimg.com/v2-e4bbe9b8e1236ed2e92225e69972b38c_l.jpg?source=1940ef5c",
                    "avatar_url_template": "https://picx.zhimg.com/v2-e4bbe9b8e1236ed2e92225e69972b38c.jpg?source=1940ef5c",
                    "badge": [],
                    "badge_v2": {
                        "detail_badges": [],
                        "icon": "",
                        "merged_badges": [],
                        "night_icon": "",
                        "title": ""
                    },
                    "exposed_medal": {
                        "avatar_url": "https://picx.zhimg.com/v2-cdc7c578bc7555f8113a409eaf2704b8_l.png?source=1940ef5c",
                        "description": "累计登录 365 天",
                        "medal_avatar_frame": "",
                        "medal_id": "972480281613197312",
                        "medal_name": "每天逛逛",
                        "mini_avatar_url": "https://picx.zhimg.com/v2-cdc7c578bc7555f8113a409eaf2704b8_r.png?source=1940ef5c"
                    },
                    "follower_count": 34,
                    "gender": 1,
                    "headline": "摆烂",
                    "id": "ecfbea7d62574f2277e22b249af23d28",
                    "is_advertiser": false,
                    "is_followed": false,
                    "is_following": false,
                    "is_org": false,
                    "is_privacy": false,
                    "name": "姜伯约",
                    "type": "people",
                    "url": "https://www.zhihu.com/api/v4/people/ecfbea7d62574f2277e22b249af23d28",
                    "url_token": "fo-bu-sheng-lian-44",
                    "user_type": "people"
                },
                "can_comment": {
                    "reason": "",
                    "status": true
                },
                "collapse_reason": "",
                "collapsed_by": "nobody",
                "comment_count": 64,
                "comment_permission": "all",
                "content": "\u003cp data-pid=\"52e5833Q\"\u003e你想让你的孩子体验一回你灰暗又失败的人生吗\u003c/p\u003e",
                "content_mark": {},
                "created_time": 1675301905,
                "decorative_labels": [],
                "editable_content": "",
                "excerpt": "你想让你的孩子体验一回你灰暗又失败的人生吗",
                "extras": "",
                "id": 2872106528,
                "is_collapsed": false,
                "is_copyable": true,
                "is_labeled": false,
                "is_mine": false,
                "is_normal": true,
                "is_sticky": false,
                "is_visible": true,
                "mark_infos": [],
                "question": {
                    "created": 1666662516,
                    "id": 562083816,
                    "question_type": "normal",
                    "relationship": {},
                    "title": "为什么现在的年轻人都拒绝生孩子？",
                    "type": "question",
                    "updated_time": 1666662516,
                    "url": "https://www.zhihu.com/api/v4/questions/562083816"
                },
                "reaction_instruction": {},
                "relationship": {
                    "is_author": false,
                    "is_authorized": false,
                    "is_nothelp": false,
                    "is_thanked": false,
                    "upvoted_followees": [],
                    "voting": 0
                },
                "relevant_info": {
                    "is_relevant": false,
                    "relevant_text": "",
                    "relevant_type": ""
                },
                "reshipment_settings": "allowed",
                "reward_info": {
                    "can_open_reward": false,
                    "is_rewardable": false,
                    "reward_member_count": 0,
                    "reward_total_money": 0,
                    "tagline": ""
                },
                "settings": {
                    "table_of_contents": {
                        "enabled": false
                    }
                },
                "sticky_info": "",
                "suggest_edit": {
                    "reason": "",
                    "status": false,
                    "tip": "",
                    "title": "",
                    "unnormal_details": {
                        "description": "",
                        "note": "",
                        "reason": "",
                        "reason_id": 0,
                        "status": ""
                    },
                    "url": ""
                },
                "thanks_count": 404,
                "thumbnail_info": {
                    "count": 0,
                    "thumbnails": [],
                    "type": "thumbnail_info"
                },
                "type": "answer",
                "updated_time": 1675301905,
                "url": "https://www.zhihu.com/api/v4/answers/2872106528",
                "visible_only_to_author": false,
                "voteup_count": 2692,
                "zhi_plus_extra_info": ""
            },
            "skip_count": false,
            "position": 0,
            "cursor": "377cfc0f521fa6e6c400de34cd937fe6"
        }
    ],
    "session": {
        "id": "1688828905373224118"
    },
    "paging": {
        "page": 9,
        "is_end": false,
        "next": "https://www.zhihu.com/api/v4/questions/562083816/feeds?cursor=377cfc0f521fa6e6c400de34cd937fe6\u0026include=data%5B%2A%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Creaction_instruction%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%3Bdata%5B%2A%5D.mark_infos%5B%2A%5D.url%3Bdata%5B%2A%5D.author.follower_count%2Cvip_info%2Cbadge%5B%2A%5D.topics%3Bdata%5B%2A%5D.settings.table_of_content.enabled\u0026limit=5\u0026offset=0\u0026order=default\u0026platform=desktop\u0026session_id=1688828905373224118"
    }
}
```

