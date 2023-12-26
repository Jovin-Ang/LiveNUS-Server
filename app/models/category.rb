class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, strict: true
  validates :description, presence: true, strict: true
  has_many :posts
end
