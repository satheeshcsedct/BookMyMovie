class CreateShowTimings < ActiveRecord::Migration[6.0]
  def change
    create_table :show_timings do |t|
      t.time :start_time
      t.references :ticket_fee

      t.timestamps
    end
  end
end
