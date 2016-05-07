class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :user_id, presence: true

  #scope
  scope :order_asc, -> { order(created_at: :asc) }

  scope :order_desc, -> { order(created_at: :desc) }
end
