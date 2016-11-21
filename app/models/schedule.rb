class Schedule < ApplicationRecord
  belongs_to :gig

  # ------------------------------------------------------------
  # METHOD USED FOR FILTER
  # available if in the same date, and this schedule time occurs later than the expect_time
  def available?(expect_time)
    return false if start_at.nil? or start_at.empty?
    return false if expect_time.cwday != weekday

    start = start_at.to_datetime.utc.strftime( "%H%M%S%N" )
    end_ = end_at.to_datetime.utc.strftime( "%H%M%S%N" )
    expect = expect_time.utc.strftime( "%H%M%S%N" )

    # result
    start <= expect and expect <= end_
  end

  # Closest datetime available of this schedule with expected time
  # If there is, then it's gonna be in the same day with expect_time
  def closest(expect_time)
    expected_wd = expect_time.cwday
    addition = weekday.to_int - expected_wd
    if addition < 0 then addition += 7 end

    result = expect_time + addition.days
    result.change({ hour: start_at.to_datetime.hour, min: start_at.to_datetime.min})
  end

  def available_now?
    available?(DateTime.now)
  end
end
