class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :title
      t.string :description
      t.text :url
      t.timestamps null: false
    end
  end
end
