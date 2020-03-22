# == Schema Information
#
# Table name: show_timings
#
#  id            :bigint           not null, primary key
#  start_time    :time
#  ticket_fee_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ShowTiming < ApplicationRecord
  has_and_belongs_to_many :theaters
  belongs_to :ticket_fee

  default_scope { order(start_time: :asc) }

  def calculate_ticket_price(current_user = nil, *args)
    original_price = ticket_fee&.price
    price_discount = 0
    percentage_discount = 0
    percentage_discount += Discount.flat5&.percentage if current_user&.female?
    args.compact.each do |offer|
      price_discount += offer.price if offer.price?
      percentage_discount += offer.percentage if offer.percentage?
    end
    discount_price = original_price * (percentage_discount / 100) + price_discount
    original_price - discount_price
  end

  def past_show?
    today = Date.current
    time = start_time
    Time.new(today.year, today.month, today.day, time.hour, time.min, time.sec)&.in_time_zone&.past?
  end
end
