class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]
  validates :fullname, presence: true, length: {maximum: 50}

  has_many :rooms
  has_many :reservations
  has_many :reviews

  def self.from_omniauth(auth)
    user = User.find_by_email(auth.info.email)
    return user if user
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.image = auth.info.image
      user.provider = auth.provider
      user.uid = auth.uid
      user.fullname = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.save
    end
  end
end
