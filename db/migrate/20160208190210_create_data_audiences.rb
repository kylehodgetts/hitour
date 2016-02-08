class CreateDataAudiences < ActiveRecord::Migration
  def change
    create_table :data_audiences do |t|
      t.references :data,index: true
      t.references :audience,index: true
      t.timestamps null: false
    end
  end
end
