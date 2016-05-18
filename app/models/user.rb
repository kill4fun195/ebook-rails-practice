class User < ActiveRecord::Base
  #association
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy

  #validation
  validates :email, confirmation: true
  validates :name_user, length: { minimum: 5 }
  validates :password, length: { in: 3..20 }
  validates :role, presence: true

  #search
  def authenticate(user_password)
    self.password == user_password
  end

  #scope 
  scope :order_asc, -> { order(created_at: :asc) }

  scope :order_desc, -> { order(created_at: :desc) }

end
