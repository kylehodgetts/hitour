class AddUniqueTourDate < ActiveRecord::Migration
  def change
    add_index :tour_sessions, [:tour_id, :start_date], :unique => true
  end
end
