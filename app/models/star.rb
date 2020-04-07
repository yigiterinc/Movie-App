class Star < ApplicationRecord
  has_many :user_stars
  has_many :users, through: :user_stars

  has_many :movie_stars
  has_many :movies, through: :movie_stars
end
