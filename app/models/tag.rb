class Tag < ActiveRecord::Base
  resourcify
  #associate
  has_many :articles,through: :tag_articles
  has_many :tag_articles ,dependent: :destroy

  #scope 
  scope :order_asc, -> { order(created_at: :asc) }

  scope :order_desc, -> { order(created_at: :desc) }

  #friendly_id 
  extend FriendlyId
  friendly_id :name_tag, use: :slugged
end
