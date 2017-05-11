class Rating < ApplicationRecord

  belongs_to :review
  # has_one :user, through: :review
  include RatingsHelper

  attr_accessor :time_taken_minutes, :time_taken_hours

  def hours_minutes_to_minutes
    self.time_taken_minutes.to_i + (self.time_taken_hours.to_i * 60)
  end

end
