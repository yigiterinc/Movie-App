class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.date :released
      t.string :runtime
      t.string :director
      t.text :plot
      t.string :language
      t.float :metascore
      t.float :imdb_rating

      t.timestamps
    end
  end
end
