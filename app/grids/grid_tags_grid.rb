class GridTagsGrid

  include Datagrid

  scope do
    Tag
  end
  
  filter(:name_tag) do |value|
    where("name_tag LIKE '%#{value}%'")
  end

  column(:id)
  column(:name_tag)
  column(:article_number) do |model|
    model.articles.size
  end
  
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_backend_tag_path(model.id), 
      view_path: backend_tag_path(model.id),
      delete_path: backend_tag_path(model.id)
    )
  end
end
