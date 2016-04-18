class CreateCategoryArticles < ActiveRecord::Migration
  def change
    create_table :category_articles do |t|
      t.belongs_to :article,index: true
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
  end
end
