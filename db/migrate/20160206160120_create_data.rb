class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :title
      t.text :description
      t.text :url
      t.references :point
      t.timestamps null: false
    end

    def title
    	:title
    end
  end
end
