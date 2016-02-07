class CreatePointDats < ActiveRecord::Migration
  def change
    create_table :point_dats do |t|
  	 t.references :data,index: true
  	 t.references :point,index: true
  	 t.integer :data_id
  	 t.integer :point_id
     t.timestamps null: false
    end
  end
end


