class AddLatitudeAndLongtitudeToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :latitude, :float
    add_column :rooms, :longtitude, :float
  end
end
