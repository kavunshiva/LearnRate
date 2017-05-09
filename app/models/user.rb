class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  has_many :lessons, through: :reviews
  has_many :ratings, through: :reviews
  has_many :tags, through: :reviews

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  validates :username, presence: { scope: true, message: "must be entered" }
  validates :first_name, presence: { scope: true, message: "must be entered" }
  validates :last_name, presence: { scope: true, message: "must be entered" }

  # if has_secure_password
  #   validates_confirmation_of :password
  # end

end
