class User < ActiveRecord::Base
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy

  def authenticate(user_password)
    self.password == user_password
  end
end
