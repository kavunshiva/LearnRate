class Review < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_one :rating
  has_one :tag
end
