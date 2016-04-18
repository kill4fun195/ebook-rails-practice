class AddViewerToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :viewer, :integer
  end
end
