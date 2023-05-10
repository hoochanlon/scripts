import re
import json

pattern = re.compile(r'\d+')
regex_str = pattern.pattern  # 将正则表达式编译为字符串

data = {'regex': regex_str}
json_str = json.dumps(data)

with open('output.json', 'w') as f:
    f.write(json_str)
