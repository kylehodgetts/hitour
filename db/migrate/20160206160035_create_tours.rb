class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :name
      t.references :audience
      t.timestamps null: false
    end
  end
end
