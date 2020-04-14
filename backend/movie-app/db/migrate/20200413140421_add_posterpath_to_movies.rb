class AddPosterpathToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :poster_path, :string
  end
end
