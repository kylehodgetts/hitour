class AddIndexToPointName < ActiveRecord::Migration
  def change
  	add_index :points, :name
  end
end
