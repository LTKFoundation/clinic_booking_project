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

  def self.search(query)
    where('expertise ILIKE ?', "%#{query}%")
  end

  private

  def self.default_doctors
    Doctor.create(name: 'Kien Do', phone: '098XXXXXX', expertise: 'Nhi, phu khoa',
      description: 'Chuyen gia dau nganh', email: 'kien@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Long Vu', phone: '098XXXXXX', expertise: 'Nhi, phu khoa',
      description: 'Chuyen gia dau nganh', email: 'long@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Tu Nguyen', phone: '098XXXXXX', expertise: 'Nhi, phu khoa',
      description: 'Chuyen gia dau nganh', email: 'tu@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Vinh Ta', phone: '098XXXXXX', expertise: 'Nhi, phu khoa',
      description: 'Chuyen gia dau nganh', email: 'vinh@gmail.com', password: '123456'
    )
  end
end
