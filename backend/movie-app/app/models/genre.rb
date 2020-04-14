class Genre < ApplicationRecord
  has_many :user_genres
  has_many :users, through: :user_genres

  has_many :movie_genres
  has_many :movies, through: :movie_genres
end
