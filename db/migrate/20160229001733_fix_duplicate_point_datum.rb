class FixDuplicatePointDatum < ActiveRecord::Migration
  def change
    add_index :point_data, [:point_id, :datum_id], :unique => true
  end
end
