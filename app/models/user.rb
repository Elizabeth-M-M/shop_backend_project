class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum:8}
end
