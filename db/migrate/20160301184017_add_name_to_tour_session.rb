class AddNameToTourSession < ActiveRecord::Migration
  def change
    add_column :tour_session, :name, :string
    add_index :tour_session, :passphrase
  end
end
