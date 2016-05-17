class GridCategoriesGrid

  include Datagrid

  scope do
    Category
  end
  
  filter(:name_category) do |value|
    where("name_category LIKE '%#{value}%'")
  end

  column(:id)
  column(:name_category)
  column(:article_number) do |model|
    model.articles.size
  end
  
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_category_path(model.id), 
      view_path: category_path(model),
      delete_path: category_path(model.id)
    )
  end
end
