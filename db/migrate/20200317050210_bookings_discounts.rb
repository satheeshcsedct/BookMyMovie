class BookingsDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_join_table :bookings, :discounts
  end
end
