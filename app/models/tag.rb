class Tag < ApplicationRecord
  has_one :review
  has_one :user, through: :review
end
