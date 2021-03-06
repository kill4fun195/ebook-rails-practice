class Article < ActiveRecord::Base
  resourcify
  #relations
  belongs_to :user
  has_many :categories, through: :category_articles
  has_many :category_articles,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, through: :tag_articles
  has_many :tag_articles,dependent: :destroy

  #paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  #scopes
  scope :order_asc, -> { order(created_at: :asc) }
  scope :order_desc, -> { order(created_at: :desc) }
  scope :search ,->(search){where("title LIKE ? OR description LIKE ?", "%#{search}%","%#{search}%")}

  #friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged
  

end
