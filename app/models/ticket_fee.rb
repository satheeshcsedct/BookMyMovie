# == Schema Information
#
# Table name: ticket_fees
#
#  id         :bigint           not null, primary key
#  show_type  :string(255)
#  price      :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TicketFee < ApplicationRecord
end
