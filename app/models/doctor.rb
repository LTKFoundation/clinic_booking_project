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

  # Search doctor by multiple columns and assoiciated model Clinic
  # Usage `Doctor.search_by(query)`
  pg_search_scope :search, against: [:name, :expertise], associated_against: {
    clinics: [:address, :name]
  }, ignoring: :accents
  # FILTER BY EXPERTISE
  pg_search_scope :filter_by_expertise, against: :expertise, ignoring: :accents
  # FILTER BY CITY
  pg_search_scope :filter_by_city,
    associated_against: { clinics: [ :address ] },
    ignoring: :accents

  def available?(expect_time)
    gigs.each do |g|
      g.schedules.each do |s|
        if s.available?(expect_time)
          return true
        end
      end
    end
    false
  end

  def available_schedules
    result = []
    gigs.each do |g|
      g.schedules.each do |s|
        result << s if s.start_at.present? or !s.start_at.empty?
      end
    end

    return result
  end

  private

  # Doctors seed
  def self.default_doctors
    Doctor.create(name: 'Kiên Đỗ', phone: '098XXXXXX', expertise: 'Sản',
      description: 'Chuyen gia dau nganh', email: 'kien@gmail.com', password: '123456'
    )
    Doctor.create(name: 'Long Vũ', phone: '098XXXXXX', expertise: 'Sản',
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
