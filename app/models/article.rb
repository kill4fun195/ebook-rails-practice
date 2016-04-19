class Article < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :category_articles
  has_many :category_articles,dependent: :destroy
  has_many :comments, dependent: :destroy
   has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

 def self.search(search)
     where("title LIKE ? OR description LIKE ?", "%#{search}%","%#{search}%") 
     
  end

end
