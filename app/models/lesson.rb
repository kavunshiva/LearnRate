class Lesson < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  has_many :ratings, through: :reviews
  has_many :tags, through: :reviews
end
