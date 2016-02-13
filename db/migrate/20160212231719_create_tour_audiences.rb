class CreateTourAudiences < ActiveRecord::Migration
  def change
    create_table :tour_audiences do |t|
      t.references :tour,index: true
      t.references :audience,index: true
      t.timestamps null: false
    end
  end
end
