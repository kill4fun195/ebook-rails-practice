class User < ActiveRecord::Base
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy
  
  def authenticate(user_password)
    self.password == user_password
  end

  #scope 
  scope :order_asc, -> { order(created_at: :asc) }

  scope :order_desc, -> { order(created_at: :desc) }

end
