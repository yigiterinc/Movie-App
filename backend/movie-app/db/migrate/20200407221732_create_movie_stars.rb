class CreateMovieStars < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_stars do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :star, null: false, foreign_key: true

      t.timestamps
    end
  end
end
