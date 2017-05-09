class Rating < ApplicationRecord

  belongs_to :review
  # has_one :user, through: :review


end
