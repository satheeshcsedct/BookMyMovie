class TheatersShows < ActiveRecord::Migration[6.0]
  def change
    create_join_table :theaters, :show_timings
  end
end
