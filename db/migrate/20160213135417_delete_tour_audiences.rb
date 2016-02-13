class DeleteTourAudiences < ActiveRecord::Migration
  def change
  	drop_table :tour_audiences
  end
end
