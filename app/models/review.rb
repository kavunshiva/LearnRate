class Review < ApplicationRecord

  belongs_to :user
  belongs_to :lesson
  has_one :rating
  has_one :tag

  validates :comment, presence: { scope: true, message: "must be entered" }


  
end
