class RenameLongtitudeToLongitude < ActiveRecord::Migration
  def change
    rename_column :rooms, :longtitude, :longitude
  end
end
