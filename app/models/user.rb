class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :email, presence: true, uniqueness: {case_sensitive: false}

  has_many :questions

  def image_or_nil
    avatar || "http://media.auswalk.com.au/wp-content/themes/auswalk/img/blank-avatar.svg"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
    end
  end

  after_create :welcome_email
  def welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def commented?(doctor)
    return DoctorComment.find_by(doctor_id: doctor.id, user_id: self.id)
  end

end
