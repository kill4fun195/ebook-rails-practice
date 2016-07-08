class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name_tag

      t.timestamps null: false
    end
  end
end
