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
require 'test_helper'

class ReleaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
