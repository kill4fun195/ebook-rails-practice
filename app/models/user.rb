class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #cancancan
  resourcify

  #rolify
  rolify   
  after_create :default_role

  #method edit
  def update_info(params)
    self.assign_attributes(params)
    if self.valid?
    else
    self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)

    p "ERRPOR!"
    p self.errors.full_messages.to_sentence
    end
  end

  #asociation       
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy

  #scope
  scope :order_asc, -> { order(created_at: :asc) }
  scope :order_desc, -> { order(created_at: :desc) }

  private

  def default_role
    self.add_role "member"
  end


end
