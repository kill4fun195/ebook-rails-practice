class GridUsersGrid

  include Datagrid

  scope do
    User
  end
  
  filter(:name_user) do |value|
    where("name_user LIKE '%#{value}%'")
  end
  
  filter(:email) do |value|
    where("email LIKE '%#{value}%'")
  end

  column(:id)
  column(:name_user)
  column(:email)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_backend_user_path(model), 
      view_path: backend_user_path(model),
      delete_path: backend_user_path(model)
    )
  end
end
