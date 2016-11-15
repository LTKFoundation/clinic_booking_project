class Doctor < ApplicationRecord
  # Devise stuff
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validation
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  # Stuff for pg_search
  include PgSearch

  # Relations
  has_many :gigs
  has_many :clinics, through: :gigs

  def verified?
    self.verified_at != nil
  end

  def addresses
  end

  # Search doctor by multiple columns and assoiciated model Clinic
  # Usage `Doctor.search_by(query)`
  pg_search_scope :search, against: [:name, :expertise], associated_against: {
    clinics: [:address, :name]
  }, ignoring: :accents

  pg_search_scope :filter_by_expertise, against: :expertise, ignoring: :accents

  pg_search_scope :filter_by_city,
    associated_against: { clinics: [ :address ] },
    ignoring: :accents

  private

  # Doctors seed
  def self.default_doctors
    Doctor.create(name: 'Kiên Đỗ', phone: '098XXXXXX', expertise: 'Nhi, sản',
      description: 'Chuyen gia dau nganh', email: 'kien@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Long Vũ', phone: '098XXXXXX', expertise: 'Nhi, sản',
      description: 'Chuyen gia dau nganh', email: 'long@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Tu Nguyen', phone: '098XXXXXX', expertise: 'Nhi',
      description: 'Chuyen gia dau nganh', email: 'tu@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Vinh Ta', phone: '098XXXXXX', expertise: 'Nhi',
      description: 'Chuyen gia dau nganh', email: 'vinh@gmail.com', password: '123456'
    )
  end
end
