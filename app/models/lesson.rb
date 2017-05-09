class Lesson < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews
  has_many :ratings, through: :reviews
  has_many :tags, through: :reviews

  validates :name, presence: { scope: true, message: "must be entered" }
  validates :description, presence: { scope: true, message: "must be entered" }
  validates :url, presence: { scope: true, message: "must be entered" }
  validates_format_of :unit_location, :with => /\d{2}-\d{2}-\d{3}/, message: "must be formatted as ##-##-###"

end
