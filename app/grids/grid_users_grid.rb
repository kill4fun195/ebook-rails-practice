class GridUsersGrid

  include Datagrid

  scope do
    User
  end
  filter(:role, :enum, :select => ["admin","member"])
  filter(:name_user) do |value|
    where("name_user LIKE '%#{value}%'")
  end
  filter(:email) do |value|
    where("email LIKE '%#{value}%'")
  end

  column(:id)
  column(:name_user)
  column(:role)
  column(:password)
  column(:email)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:action, header: "Chuc nang", html: true) do |model|
    render(
      "datagrid/actions", 
      edit_path: edit_user_path(model), 
      view_path: user_path(model),
      delete_path: user_path(model)
    )
  end
end
