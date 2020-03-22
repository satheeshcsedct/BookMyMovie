class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.string :actors
      t.string :banner_url

      t.timestamps
    end
  end
end
