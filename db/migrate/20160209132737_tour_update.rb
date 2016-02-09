class TourUpdate < ActiveRecord::Migration
  def change
  	add_column :tours, :name, :string
    add_index :tours, :name
    add_reference :tours, :audience, index: true
  end
end
