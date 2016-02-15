class CreatePointData < ActiveRecord::Migration
  def change
    create_table :point_data do |t|
      t.references :point,index: true
      t.references :datum,index: true
      t.integer :rank
      t.timestamps null: false
    end
  end
end
