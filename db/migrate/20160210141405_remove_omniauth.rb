class RemoveOmniauth < ActiveRecord::Migration
  def change
    remove_index :users, :provider
    remove_index :users, :uid
    remove_column :users, :uid
    remove_column :users, :provider
  end
end
