class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :discount_type
      t.float :price
      t.float :percentage
      t.string :coupon_code
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
