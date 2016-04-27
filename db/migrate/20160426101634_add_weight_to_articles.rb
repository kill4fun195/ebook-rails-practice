class AddWeightToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :weight, :string
  end
end
