class CreateTheaters < ActiveRecord::Migration[6.0]
  def change
    create_table :theaters do |t|
      t.string :name
      t.integer :seat_limit
      t.string :city
      t.string :area

      t.timestamps
    end
  end
end
