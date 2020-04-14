class ReviseMovieCols < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :metascore
    add_column :movies, :budget, :integer
  end
end
