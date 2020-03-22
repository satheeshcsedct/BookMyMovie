# == Schema Information
#
# Table name: bookings
#
#  id             :bigint           not null, primary key
#  amount         :float(24)
#  date           :date
#  user_id        :bigint           not null
#  release_id     :bigint           not null
#  show_timing_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :release
  belongs_to :show_timing

  has_one :movie, through: :release
  has_one :theater, through: :release

  has_and_belongs_to_many :discounts

  scope :filtered_list_for, ->(movie_id, theater_id, show_timing_id, date) { joins(:movie, :theater).where('movies.id = ? and theaters.id = ? and show_timing_id = ? and date = ?', movie_id, theater_id, show_timing_id, date) }

  def past_show?
    today = date
    time = show_timing&.start_time
    Time.new(today.year, today.month, today.day, time.hour, time.min, time.sec)&.in_time_zone&.past? if today
  end
end
