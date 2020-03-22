class CreateTicketFees < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_fees do |t|
      t.string :show_type
      t.float :price

      t.timestamps
    end
  end
end
