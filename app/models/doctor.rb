class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: {case_sensitive: false}

   has_many :gigs
   has_many :clinics, through: :gigs

   def verified?
    self.verified_at != nil
   end
end
