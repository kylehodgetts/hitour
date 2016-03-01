class AddNameAndPassPhraseIndexToTourSession < ActiveRecord::Migration
  def change
    add_column :tour_sessions, :name, :string
    add_index :tour_sessions, :passphrase
  end
end
