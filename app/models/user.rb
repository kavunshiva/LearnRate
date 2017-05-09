class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  has_many :lessons, through: :reviews
  has_many :ratings, through: :reviews
  has_many :tags, through: :reviews
end
