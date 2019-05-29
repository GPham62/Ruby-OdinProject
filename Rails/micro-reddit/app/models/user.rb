class User < ApplicationRecord
  has_many :posts
  has_many :comments
  validates :name, presence: true, uniqueness: {case_sensitive: true}, length: {minimum: 6, maximum: 15}
  validates :email, presence: true, uniqueness: {case_sensitive: true}, length: {maximum: 255},
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
