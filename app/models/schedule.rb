class Schedule < ApplicationRecord
  belongs_to :gig

  # ------------------------------------------------------------
  # METHOD USED FOR FILTER

  # Closest datetime available of this schedule with expected time
  # If there is, then it's gonna be in the same day with expect_time
  def closest(expect_time)
    expected_wd = expect_time.cwday
    binding.pry
    addition = weekday - expected_wd
    if addition < 0 then addition += 7 end

    result = expect_time + addition.days
    result.change({ hour: start_at.hour, min: start_at.min})
  end

  def available?(expect_time)
    return false if start_at.nil? or !start_at.present? or start_at.empty?
    closest_available = closest(expect_time)
    closest_available.to_date == expect_time.to_date and
      closest_available > expect_time
  end

  def available_now?
    closest < DateTime.now
  end
end
