class GridArticlesGrid

  include Datagrid

  scope do
   Article.includes(:categories,:comments)
  end
  
  filter(:title) do |value|
    where("lower(title) LIKE ?", "%#{value}%")
  end

  filter(:author, style: "display:hidden") do |value|
    joins(:user).where("users.name_user LIKE '%#{value}%'")
  end

  filter(:created_at ) do |value|
    start_date, end_date = value.split("-").map(&:strip)
    where("created_at >= ? AND created_at <= ?", Date.parse(start_date), Date.parse(end_date))
  end

  column(:id)
  column(:title) do |model|
    model.title.truncate(50)
  end
  column(:author) do |model|
    model.user.name_user
  end
  column(:comments) do |model|
    model.comments.size
  end
  column(:linkdownload) do |model|
    model.linkdownload.truncate(20)
  end
  column(:weight)
  column(:image,html: true) do |model|
    render(
      "datagrid/image",
      image: model.avatar.url(:thumb)
      )
  end
  column(:created_at) do |model|
    model.created_at.to_date
  end
  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_backend_article_path(model.id), 
      view_path: backend_article_path(model.id),
      delete_path: backend_article_path(model.id)
    )
  end
end
