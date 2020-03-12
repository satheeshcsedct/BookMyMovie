class User < ApplicationRecord
  has_secure_password

  enum genders: [:male, :female, :transgender]

  validates :name, :email, :gender, presence: true
  validates :email, uniqueness: true
end
