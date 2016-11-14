class Search < ApplicationRecord
  def self.doctors(query)
    search_doctors(query)
  end

  def self.search_doctors(query)
    if query.present?
      Doctor.search(query)
    end
  end

  CITY = {
    hn: ['%Ha noi%', '%ha noi%', '%Hà Nội%', '%hanoi%'],
    hcm: ['%Ho Chi Minh%']
  }

  def self.doctors_in_city(city_in_s)
    # convert to symbol
    city_in_sym = city_in_s.to_sym
    # get an array of similar name
    name_array = Search::CITY[city_in_sym]
    # Return array of unique doctors works in clinics where address is the city
    Clinic.where('address ILIKE ANY ( array[?])', name_array).map{|clinic| clinic.doctors}.uniq
  end
end
