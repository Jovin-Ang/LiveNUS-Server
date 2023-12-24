class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :api
  validates :email, presence: true, uniqueness: true, strict: true
  validates :username, presence: true, uniqueness: true, strict: true
  validates :first_name, presence: true, strict: true
  validates :last_name, presence: true, strict: true
  has_one :role
end
