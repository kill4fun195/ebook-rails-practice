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

task :wowebook_create_article_list => :environment do
  require 'mechanize'
  agent = Mechanize.new 
  page = agent.get('http://www.wowebook.pw/page/5/')
  array_title = Array.new(9)
  array_details = Array.new(9)
  array_description = Array.new(9)
  array_weight = Array.new(9)
  array_linkdownload = Array.new(9)
  array_user_id = Array.new(9)
  array_avatar = Array.new(9)

  i = -1 

  page.search("h2.post-title a").each do |item|
   array_title[i+=1] = item.text.to_s
  end

  i=0

  while i < 10
    article = page.link_with(:text => array_title[i].to_s).click
    array_linkdownload[i] = article.link_with(:text => "").href.to_s
    page_download = article.link_with(:text => "").click
    doc = Nokogiri::HTML page_download.body
    array_weight[i] = doc.search("h1.title sup").text.to_s
    array_avatar[i] = "http://" + article.search(".entry-inner p img").attr("src").to_s.split("//")[1].to_s
    array_details[i] = "<h3>Book Details</h3>"+"\n" + article.search(".entry-inner h3 + ul").to_s
    array_description[i] = "<p>" + article.search(".entry-inner").to_s.split("<h3>")[0].split("\"><br>")[1].to_s
    i+=1
  end

  (0..9).each do |i|
   article = Article.create(title: array_title[i],details: array_details[i],description: array_description[i],user_id: 1 ,avatar: array_avatar[i].to_s,linkdownload: array_linkdownload[i],weight: array_weight[i])
   category_ids = [1,2,3]
   category_ids.each do |cat_id|
      article.category_articles.create(category_id: cat_id)
   end

  end

end
