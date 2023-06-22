
[csdn - Ruby on Rails 入门之：(6) Ruby中常用运算符](https://blog.csdn.net/watkinsong/article/details/8019461)

titles.first(3).each do |title| 语法糖

存在不少语法糖，难怪说所谓简洁。

通过对语法糖的了解反倒是很让代码与逻辑更完善。

```
# 将解压出来的文件夹移动到指定目录下
puts "正在移动解压后的文件夹到 #{theme_path} ..."
FileUtils.move(Dir.glob(File.join(unzip_path, '**', '*')), theme_path, :force => true)
```

开放格式API：https://www.fileformat.com/zh/

https://www.tairaengineer-note.com/ruby-rubyxl-specify-sheet-name/

https://www.cnblogs.com/dajianshi/p/11613060.html
