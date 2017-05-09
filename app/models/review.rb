class Review < ApplicationRecord

  belongs_to :user
  belongs_to :lesson
  belongs_to :rating
  belongs_to :tag

  validates :comment, presence: { scope: true, message: "must be entered" }

end
