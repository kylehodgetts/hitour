class FixDuplicateDatumAudience < ActiveRecord::Migration
  def change
    add_index :data_audiences, [:datum_id, :audience_id], :unique => true
  end
end
