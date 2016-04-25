class AddLinkDownloadToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :linkdownload , :string
  end
end
