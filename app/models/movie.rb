# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :text(65535)
#  actors      :string(255)
#  banner_url  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Movie < ApplicationRecord
  has_many :releases
  has_many :theaters, through: :releases

  scope :running_and_upcoming, -> { joins(:releases).where('releases.start_date <= ? AND releases.end_date >= ? OR releases.start_date > ?', Date.today, Date.today, Date.today) }
  scope :latest_screened, -> { joins(:releases).order('releases.start_date desc, releases.end_date asc') }
end
