class User < ApplicationRecord
  has_secure_password # Method from bcrypt

  has_many :user_movies
  has_many :movies, through: :user_movies

  has_many :user_stars
  has_many :stars, through: :user_stars

  has_many :user_genres
  has_many :genres, through: :user_genres

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
