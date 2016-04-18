class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name_user
      t.string :role
      t.text :email
      t.text :password

      t.timestamps null: false
    end
  end
end
