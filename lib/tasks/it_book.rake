task :it_ebook_create_article_list => :environment do
  require 'mechanize'
  agent = Mechanize.new 
  page = agent.get("http://it-ebooks.info/")
  array_title = Array.new
  i = -1 
  page.search("table tr")[4].search("td.top table tr td:eq(2) a").each do |item|
   array_title.push(item.text.to_s)
  end
  i = -1 
  page.search("table tr")[4].search("td.top table tr td:eq(5) a").each do |item|
   array_title.push(item.text.to_s)
  end
  i=0
  while i < array_title.size.to_i
    array_details = Array.new
    array_description = Array.new
    array_weight = Array.new
    array_linkdownload = Array.new
    array_avatar = Array.new
    tag_ids = Array.new
    article = page.link_with(:text => array_title[i].to_s).click
    array_description[i] = article.search("table.ebook_view tr td")[1].search("span").to_s
    n = 1
    article.search("table.ebook_view tr td")[1].search("span + table tr").each do |item|
      if n > 9 
        next
      end
      if n == 3
        n +=1
        array_details[i] = array_details[i].to_s + article.search("table.ebook_view tr td")[1].search("span + table tr")[2].to_s.gsub(/<b item.+<\/b><b>/,"<b>") + "<br>"
        next
      end
      array_details[i] = array_details[i].to_s + item.to_s + "<br>"
      n += 1
    end
    article.search("table.ebook_view tr td:eq(2) span a").each do |item|
      tag_ids.push(Tag.find_by(name_tag: item.text.titlecase).id)
    end
    array_weight[i] = article.search("table.ebook_view tr td")[1].search("span + table tr")[7].text.split(":")[1].to_s
    array_linkdownload[i] = article.search("table.ebook_view tr td")[1].search("span + table tr")[10].search("td")[1].search("a").attr("href").text.to_s
    array_avatar[i] = "http://it-ebooks.info" + article.search("table.ebook_view tr td")[0].search("img")[0].attr("src").to_s
    article = Article.create(title: array_title[i],details: array_details[i],description: array_description[i],user_id: 1 ,avatar: array_avatar[i].to_s,linkdownload: array_linkdownload[i],weight: array_weight[i])
    if tag_ids.size > 0
      tag_ids.each do |tag_id|
        article.tag_articles.create(tag_id: tag_id)
      end
    else
      article.category_articles.create(category_id: 68)
    end  
    puts "create succsess book st.#{i+1}"
    i += 1
  end

end

task :it_ebook_create_publisher_list => :environment do
  agent = Mechanize.new 
  page_num = 1
  array_publisher = Array.new
  while page_num < 17
    url = 'http://it-ebooks.info/publisher/'+page_num.to_s+'/'
    page = agent.get(url)
    array_publisher[page_num - 1] = page.search("td.top div h1").text.to_s
    page_num += 1
  end 
end



task :it_ebook_create_tag_list => :environment do
  agent = Mechanize.new 
  page_num = 1
  array_tag = Array.new
  while page_num < 17
    array_title = Array.new
    url = 'http://it-ebooks.info/publisher/'+page_num.to_s+'/'
    page = agent.get(url)
    title_index = -1 
    page.search("table.main tr:eq(2) table tr td:eq(2) a").each do |item|
     array_title[title_index +=1] = item.text.to_s
    end
    (0..array_title.size-1).each do |i|
       article = page.link_with(:text => array_title[i]).click
       article.search("table.ebook_view tr td:eq(2) span a").each do |text_tag|
        if array_tag.include?(text_tag.text.to_s)
          next
        end
        array_tag.push(text_tag.text.to_s)
       end
    end
    page_num_next = 2
    while page_num_next < 40
      array_title_next_page = Array.new
      next_url = 'http://it-ebooks.info/publisher/'+page_num.to_s+'/' +'page/'+page_num_next.to_s+'/'
      next_page = agent.get(next_url)
      if next_page.uri.to_s ==  "http://it-ebooks.info/book/2717/"
        next
      end
      title_index = -1
      next_page.search("table.main tr:eq(2) table tr td:eq(2) a").each do |item|
        array_title_next_page[title_index +=1] = item.text.to_s
      end
      (0..array_title_next_page.size-1).each do |i|
        article = next_page.link_with(:text => array_title_next_page[i].to_s).click
        article.search("table.ebook_view tr td:eq(2) span a").each do |text_tag|
         if array_tag.include?(text_tag.text.to_s.strip)
           next
         end
         array_tag.push(text_tag.text.to_s.strip)
         end
        end
      puts "xong trang #{page_num } cua #{page_num_next}"  
      page_num_next += 1
     end
    page_num += 1
  end 
  a = []
  (0..array_tag.size-1).each do |i|
    a[i] = array_tag[i].titlecase
  end
  a = a.uniq
  (0..a.size-1).each do |i|
    Tag.create(name_tag: a[i])
  end

end

 
