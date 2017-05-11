module RatingsHelper

  def to_hours_minutes
    "#{to_only_hours}H #{to_only_minutes}M"
  end

  def to_only_hours
    self.time_taken / 60
  end

  def to_only_minutes
    self.time_taken % 60
  end

end
