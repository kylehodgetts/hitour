class AddActivationToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :activated, :boolean
  	add_column :users, :activated, :boolean,null: false, default: false
  end
end
