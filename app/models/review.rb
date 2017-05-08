class Review < ApplicationRecord
  belongs_to :user
  belongs_to :rating
  belongs_to :lesson
  belongs_to :tag
end
