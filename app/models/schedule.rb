class Schedule < ApplicationRecord
  belongs_to :gig

  def closest
    ("#{weekday} #{ start_at.to_s(:time) }").to_datetime
  end

  def available?(expect_time)
    expect_time > closest
  end

  def available_now?
    closest < DateTime.now
  end
end
