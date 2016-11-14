class Search < ApplicationRecord
  def self.doctors(query)
    search_doctors(query)
  end

  def self.search_doctors(query)
    if query.present?
      Doctor.search(query)
    end
  end
end
