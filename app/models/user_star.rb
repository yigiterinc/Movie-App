class UserStar < ApplicationRecord
  belongs_to :user
  belongs_to :star
end
