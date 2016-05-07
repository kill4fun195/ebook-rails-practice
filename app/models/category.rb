class Category < ActiveRecord::Base
  has_many :articles,through: :category_articles
  has_many :category_articles ,dependent: :destroy

  #scope 
  scope :order_asc, -> { order(created_at: :asc) }

  scope :order_desc, -> { order(created_at: :desc) }

end
