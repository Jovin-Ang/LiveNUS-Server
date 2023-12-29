class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :api
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  belongs_to :role
  has_many :posts
  has_many :posts_votes
  has_many :posts_likes
  has_many :comments
  has_many :comments_votes
  has_many :comments_likes
end
