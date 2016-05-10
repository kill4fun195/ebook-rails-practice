class GridArticlesGrid

  include Datagrid

  scope do
   Article.includes(:categories,:comments)
  end

  filter(:id)
  
  filter(:title) do |value|
    where(" title LIKE '%#{value}%' ")
  end

  column(:id)
  column(:title)
  column(:details) do |model|
    model.details.truncate(100)
  end
  column(:description) do |model|
    model.description.truncate(100)
  end
  column(:author) do |model|
    model.user.name_user
  end
  column(:comments) do |model|
    model.comments.size
  end
  column(:linkdownload) do |model|
    model.linkdownload.truncate(50)
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
      edit_path: edit_article_path(model), 
      view_path: article_path(model),
      delete_path: article_path(model)
    )
  end
end
