class AddGenderToStar < ActiveRecord::Migration[6.0]
  def change
    add_column :stars, :gender, :string
  end
end
