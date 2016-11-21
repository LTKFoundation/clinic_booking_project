class Schedule < ApplicationRecord
  belongs_to :gig

  # ------------------------------------------------------------
  # METHOD USED FOR FILTER

  # Closest datetime available of this schedule with expected time
  def closest(expect_time)
    weekday_int = expect_time.cwday

    puts(weekday)
    addition = "#{weekday}".to_datetime.cwday - weekday_int
    if addition < 0 then addition += 7 end

    result = expect_time + addition.days
    result.change({ hour: start_at.to_datetime.hour, min: start_at.to_datetime.min})
  end

  # available if in the same date, and this schedule time occurs later than the expect_time
  def available?(expect_time)
    closest_available = closest(expect_time)
    closest_available.to_date == expect_time.to_date and
      closest_available > expect_time
  end

  def available_now?
    closest < DateTime.now
  end
end
