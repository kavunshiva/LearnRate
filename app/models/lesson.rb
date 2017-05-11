class Lesson < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews
  has_many :ratings, through: :reviews
  has_many :tags, through: :reviews

  validates :name, presence: { scope: true, message: "must be entered" }
  validates :description, presence: { scope: true, message: "must be entered" }
  validates :url, presence: { scope: true, message: "must be entered" }
  validates_format_of :unit_location, :with => /\d{2}-\d{2}-\d{2}-\d{2}/, message: "must be formatted as ##-##-##-##"

  def average_time_taken

    time = Rating.where(review: self.reviews).average(:time_taken).to_f.round(0)
    to_hours_minutes_readout(time)
  end

  def average_helpfulness
    Rating.where(review: self.reviews).average(:helpfulness).to_f.round(1)
  end

  def average_frustration
    Rating.where(review: self.reviews).average(:frustration).to_f.round(1)
  end

  def average_quality
    Rating.where(review: self.reviews).average(:quality).to_f.round(1)
  end

  def to_hours_minutes_readout(time)
    "#{time/60} Hours #{time%60} Minutes"
  end

end
