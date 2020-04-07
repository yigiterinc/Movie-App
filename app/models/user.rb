class User < ApplicationRecord
  has_secure_password # Method from bcrypt

  has_many :user_movies
  has_many :movies, through: :user_movies

  has_many :user_stars
  has_many :stars, through: :user_stars

  has_many :user_genres
  has_many :genres, through: :user_genres
end
