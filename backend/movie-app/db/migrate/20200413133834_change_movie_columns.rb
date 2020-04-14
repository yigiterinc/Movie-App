class ChangeMovieColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :director
    remove_column :movies, :imdb_rating
    add_column :movies, :vote_average, :integer
    add_column :movies, :revenue, :integer
  end
end
