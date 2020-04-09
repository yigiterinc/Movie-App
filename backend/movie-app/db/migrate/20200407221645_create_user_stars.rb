class CreateUserStars < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stars do |t|
      t.references :user, null: false, foreign_key: true
      t.references :star, null: false, foreign_key: true

      t.timestamps
    end
  end
end
