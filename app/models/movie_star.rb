class MovieStar < ApplicationRecord
  belongs_to :movie
  belongs_to :star
end
