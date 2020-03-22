# == Schema Information
#
# Table name: discounts
#
#  id            :bigint           not null, primary key
#  name          :string(255)
#  discount_type :integer
#  price         :float(24)
#  percentage    :float(24)
#  coupon_code   :string(255)
#  active        :boolean          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Discount < ApplicationRecord
  enum discount_type: %i[price percentage]

  validates :discount_type, :price, :percentage, :coupon_code, :active, presence: true

  has_and_belongs_to_many :bookings

  def self.flat5
    find_by_coupon_code 'GIRLS5'
  end
end
