require 'open-uri'
require 'nokogiri'
require 'fileutils'
require 'zip'

# 检查系统是否安装了 aria2c
if Gem.win_platform?
  unless system("where aria2c")
    abort("请先安装 aria2c 后再运行此脚本！")
  end
else
  unless system("which aria2c")
    abort("请先安装 aria2c 后再运行此脚本！")
  end
end

# 下载壁纸函数
def download_wallpapers()
  base_path = File.join(Dir.home, 'Desktop', 'msdesign-wallpapers') # 壁纸基础路径（不包含主题包名）
  url = 'https://wallpapers.microsoft.design' # 目标网站 URL
  html = URI.open(url).read # 获取 HTML 内容
  doc = Nokogiri::HTML.parse(html) # 解析 HTML 内容

  # 筛选指定 title 属性的 a 标签，并输出它们的 href 属性值
  titles = doc.xpath('//a[@title="Download wallpaper package"]')
  count = 0 # 计数器
  puts "\n开始下载：\n"

  # titles.first(3).each do |title|
  titles.each do |title|
    download_url = title['href']
    theme_name = File.basename(download_url, '.zip').to_s
    theme_path = File.join(base_path, theme_name) # 拼接主题包完整路径
    unzip_path = File.join(theme_path)

    # 创建主题包解压目录
    FileUtils.mkdir_p(unzip_path) unless Dir.exist?(unzip_path) # 若目录不存在则创建

    # 下载 ZIP 文件
    puts "正在下载 #{theme_name} ..."
    system("aria2c #{download_url} -d '#{theme_path}'")

    # 解压 ZIP 文件
    zipfile_path = Dir.glob(File.join(theme_path, '*.zip')).first # 获取 ZIP 文件路径
    unzip_file(zipfile_path, unzip_path) if zipfile_path # 解压 ZIP 文件
    File.delete(zipfile_path) if zipfile_path # 删除 ZIP 压缩包

    count += 1
    puts "已下载 #{count} 个壁纸主题包"
  end
end

# 解压 ZIP 文件并删除 __MACOSX 目录
def unzip_file(source, destination)
  Zip::File.open(source) do |zip_file|
    zip_file.each do |f|
      # 计算文件的目标路径
      fpath = File.join(destination, f.name.sub(/^.*\//, ''))

      # 跳过 __MACOSX 目录和隐藏文件
      next if f.name =~ /(__MACOSX|.DS_Store)/ || f.directory?

      puts "正在解压：#{f.name} 到 #{destination} ..."
      zip_file.extract(f, fpath) unless File.exist?(fpath)
    end

    # 删除 __MACOSX 目录
    macosx_dir = File.join(destination, '__MACOSX')
    FileUtils.rm_rf(macosx_dir) if File.exist?(macosx_dir)
  end

  puts "#{source} 解压完成！"
end

# 调用函数示例
download_wallpapers
