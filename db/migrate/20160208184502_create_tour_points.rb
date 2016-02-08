class CreateTourPoints < ActiveRecord::Migration
  def change
    create_table :tour_points do |t|
      t.references :tour,index: true
      t.references :point,index: true
      t.integer :rank
      t.timestamps null: false
    end
  end
end
