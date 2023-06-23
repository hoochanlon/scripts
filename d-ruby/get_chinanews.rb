require 'httparty'
require 'nokogiri'
require 'spreadsheet'
require 'date'

# 获取当前时间
now = DateTime.now
# 将时间格式化为指定的字符串格式
formatted_time = now.strftime('%Y-%m-%d')

# 获取桌面路径
desktop_path = File.expand_path("~/Desktop")

# 创建一个Workbook对象，用于Excel的读写
book = Spreadsheet::Workbook.new

# 添加一个Sheet页，并且指定Sheet名称
sheet = book.create_worksheet(name: 'Sheet1')

# 定义变量row，用于循环时控制每一行的写入位置
row = 0

# 添加表头
sheet.row(row).concat ['栏目', '标题', '时间']
row += 1

# 遍历页码从1到9页
(1..9).each do |page_num|
  url = "https://www.chinanews.com.cn/scroll-news/news#{page_num}.html"

  # 反爬通用套码
  headers = {
    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
  }

  response = HTTParty.get(url, headers: headers)
  soup = Nokogiri::HTML(response.body)

  # 遍历栏目、标题和时间
  dangdu_lanmu = soup.css('div.dd_lm')
  dangdu_biaoti = soup.css('div.dd_bt')
  dangdu_time = soup.css('div.dd_time')

  # 追加具体数据
  dangdu_lanmu.each_with_index do |lanmu, index|
    sheet.row(row).concat [lanmu.content.gsub(/\[|\]/, ''), dangdu_biaoti[index].content, dangdu_time[index].content]
    row += 1
  end
end

# 拼接保存文件的路径
file_path = File.join(desktop_path, "chinanews_#{formatted_time}.xls")

# 保存Excel文件
book.write(file_path)

puts "文件已保存在：#{file_path}"
