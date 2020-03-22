# == Schema Information
#
# Table name: releases
#
#  id         :bigint           not null, primary key
#  theater_id :bigint           not null
#  movie_id   :bigint           not null
#  language   :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Release < ApplicationRecord
  belongs_to :theater
  belongs_to :movie

  has_many :bookings

  enum languages: {
    tamil: 'tamil',
    english: 'english',
    kannada: 'kannada',
    telugu: 'telugu',
    malayalam: 'malayalam',
    hindi: 'hindi'
  }

  scope :running, -> { where('start_date <= ? AND end_date >= ?', Date.current, Date.current) }
  scope :upcoming, -> { where('start_date > ?', Date.current) }
  scope :running_and_upcoming, -> { where('start_date <= ? AND end_date >= ? OR start_date > ?', Date.current, Date.current, Date.current) }
  scope :latest_screened, -> { order('start_date desc, end_date asc') }
end
