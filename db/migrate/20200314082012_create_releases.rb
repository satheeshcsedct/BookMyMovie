class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.references :theater, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.string :language
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
