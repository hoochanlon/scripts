require 'clipboard'

module NbviewerGenerator
  def self.generate_link
    base_url = "https://nbviewer.org/github"
    print "复制 GitHub ipynb 文件地址到终端，回车即可生成在线查看粘贴链接："
    github_url = gets.chomp

    while !valid_github_url?(github_url)
      print " "
      print "地址格式不正确，请重新输入："
      github_url = gets.chomp
    end

    repo_path = github_url.sub("https://github.com/", "")
    nbviewer_url = "#{base_url}/#{repo_path}"

    Clipboard.copy(nbviewer_url)
    puts "转换完成，并已将链接复制到剪贴板，直接在浏览器上粘贴即可。"
  end

  private_class_method def self.valid_github_url?(url)
    url =~ %r{^https://github.com/.+}
  end
end

NbviewerGenerator.generate_link
