class Status < ApplicationRecord
  validates :name, presence: true, uniqueness: true, strict: true
  has_many :posts
end
