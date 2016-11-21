class Schedule < ApplicationRecord
  belongs_to :gig

  def closest(expect_time)
    weekday_int = expect_time.cwday

    puts(weekday)
    addition = "#{weekday}".to_datetime.cwday - weekday_int
    if addition < 0 then addition += 7 end

    result = expect_time + addition.days
    result.change({ hour: start_at.hour, min: start_at.min})
  end

  def available?(expect_time)
    closest_available = closest(expect_time)
    closest_available.to_date == expect_time.to_date and
      closest_available > expect_time
  end

  def available_now?
    closest < DateTime.now
  end
end
