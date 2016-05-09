class GridUsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

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
      view_path: user_path(model)
    )
  end
end
