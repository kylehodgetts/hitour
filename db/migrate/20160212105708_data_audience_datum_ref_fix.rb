class DataAudienceDatumRefFix < ActiveRecord::Migration
  def change
  	 remove_column :data_audiences, :data_id
  	 add_reference :data_audiences, :datum, index: true
  end
end
