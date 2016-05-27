class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #cancancan
  resourcify

  #rolify
  rolify   

  #asociation       
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy

  #scope
  scope :order_asc, -> { order(created_at: :asc) }
  scope :order_desc, -> { order(created_at: :desc) }

end
