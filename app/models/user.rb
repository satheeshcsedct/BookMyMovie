# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  gender          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :bookings

  enum gender: %i[male female transgender]

  validates :name, :email, :gender, presence: true
  validates :email, uniqueness: true
end
