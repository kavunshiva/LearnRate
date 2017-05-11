class Rating < ApplicationRecord

  belongs_to :review
  # has_one :user, through: :review

  attr_accessor :time_taken_minutes, :time_taken_hours

  def to_hours_minutes
    "#{to_only_hours}H #{to_only_minutes}M"
  end

  def to_only_hours
    self.time_taken / 60
  end

  def to_only_minutes
    self.time_taken % 60
  end


  def hours_minutes_to_minutes
    self.time_taken_minutes.to_i + (self.time_taken_hours.to_i * 60)
  end

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
