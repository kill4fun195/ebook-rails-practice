desc "Import wish list"
task :import_list => :environment do
  require 'mechanize'
  agent = Mechanize.new
  page = agent.get('http://localhost:3000/users/sign_in')
  form = page.form
  email = form.fields.detect{|item| item.name == "user[email]"}
  email.value = "admin@yahoo.com"
  password = form.fields.detect{|item| item.name == "user[password]"}
  password.value = "123456"
  form.submit

end
task :wowebook_create_category_list => :environment do
  require 'mechanize'
  agent = Mechanize.new
  page = agent.get("http://www.wowebook.pw/")
  size_array_category = page.search("#categories-2 ul li a").length.to_i
  array_category = Array.new(size_array_category)
  (0..size_array_category-1).each do |i|
     array_category[i] = page.search("#categories-2 ul li a")[i].text.to_s
     Category.create(name_category: array_category[i])
  end

end




task :wowebook_create_article_list => :environment do
  require 'mechanize'
  agent = Mechanize.new 
  page_num = 1
  while page_num < 4
    url = 'http://www.wowebook.pw/page/' +page_num.to_s+'/'
    page = agent.get(url)
    array_title = Array.new
    array_details = Array.new
    array_description = Array.new
    array_weight = Array.new
    array_linkdownload = Array.new
    array_avatar = Array.new
    array_category = Array.new{Array.new}

    i = -1 

    page.search("h2.post-title a").each do |item|
     array_title[i+=1] = item.text.to_s
    end

    i=0

    while i < 10
      article = page.link_with(:text => array_title[i].to_s).click
      size_array_category = article.search("ul li.category a").length
      category_ids = Array.new(size_array_category)
      (0..size_array_category - 1).each do |index_category|
        array_category[i][index_category] = article.search("ul li.category a")[index_category].text.to_s
        category_ids[index_category] = Category.find_by(name_category: array_category[i][index_category]).id.to_i
      end
      array_linkdownload[i] = article.link_with(:text => "").click.uri.to_s
      page_download = article.link_with(:text => "").click
      doc = Nokogiri::HTML page_download.body
      array_weight[i] = doc.search("h1.title sup").text.to_s
      next if  array_weight[i] == ""
      array_avatar[i] = "http://" + article.search(".entry-inner p img").attr("src").to_s.split("//")[1].to_s
      array_details[i] = "<h3>Book Details</h3>"+"\n" + article.search(".entry-inner h3 + ul").to_s
      array_description[i] = "<p>" + article.search(".entry-inner").to_s.split("<h3>")[0].split("\"><br>")[1].to_s

      article = Article.create(title: array_title[i],details: array_details[i],description: array_description[i],user_id: 1 ,avatar: array_avatar[i].to_s,linkdownload: array_linkdownload[i],weight: array_weight[i])
      category_ids.each do |cat_id|
        article.category_articles.create(category_id: cat_id)
      end

      i+=1
    end
    puts "create thanh cong trang thu #{page_num }"
    page_num += 1
  end

end


