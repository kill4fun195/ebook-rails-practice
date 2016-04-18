class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :user_id, presence: true
end
