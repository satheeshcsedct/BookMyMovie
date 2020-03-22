# == Schema Information
#
# Table name: theaters
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  seat_limit :integer
#  city       :string(255)
#  area       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theater < ApplicationRecord
  has_many :releases
  has_many :movies, through: :releases
  has_and_belongs_to_many :show_timings
end
