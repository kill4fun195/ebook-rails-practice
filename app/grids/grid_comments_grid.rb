class GridCommentsGrid
  include Datagrid

  scope do
    Comment
  end

  filter(:title_article) do |value|
    joins(:article).where("articles.title LIKE '%#{value}%'")
  end
 
  filter(:name_user) do |value|
    joins(:user).where("users.name_user LIKE '%#{value}%'")
  end

  column(:id)
  
  column(:body) do |model|
    model.body.truncate(30)
  end
  column(:title_article) do |model|
    model.article.title.truncate(40)
  end
  column(:name_user) do |model|
    model.user.name_user
  end

  column(:created_at) do |model|
    model.created_at.to_date
  end
  column(:approve_comment, html: true) do |model|
     render(
      "datagrid/approve",
      approve: model.approve
      )
  end
  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_comment_path(model), 
      view_path: comment_path(model),
      delete_path: comment_path(model)
    )
  end
end
