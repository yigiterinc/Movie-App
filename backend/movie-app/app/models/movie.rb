class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :movie_stars
  has_many :stars, through: :movie_stars
end