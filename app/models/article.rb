class Article < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :category_articles
  has_many :category_articles,dependent: :destroy
  has_many :comments, dependent: :destroy

 def self.search(search)
     where("title LIKE ? OR description LIKE ?", "%#{search}%","%#{search}%") 
     
  end

end
