class User < ActiveRecord::Base
  #asociation       
  has_many :articles , dependent: :destroy
  has_many :comments , dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
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

  #omniauth-facebook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name_user = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  #scope
  scope :order_asc, -> { order(created_at: :asc) }
  scope :order_desc, -> { order(created_at: :desc) }

  private

  def default_role
    self.add_role "member"
  end


end
