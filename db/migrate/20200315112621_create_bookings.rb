class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.float :amount
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :release, null: false, foreign_key: true
      t.references :show_timing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
