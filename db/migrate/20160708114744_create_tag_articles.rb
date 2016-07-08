class CreateTagArticles < ActiveRecord::Migration
  def change
    create_table :tag_articles do |t|
      t.belongs_to :article,index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
