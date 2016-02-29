class FixDuplicationTourPoint < ActiveRecord::Migration
  def change
    add_index :tour_points, [:tour_id, :point_id], :unique => true
  end
end
