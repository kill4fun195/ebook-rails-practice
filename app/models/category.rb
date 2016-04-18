class Category < ActiveRecord::Base
  has_many :articles,through: :category_articles
  has_many :category_articles ,dependent: :destroy
end
