class CreateTourSessions < ActiveRecord::Migration
  def change
    create_table :tour_sessions do |t|
      t.references :tour, index: true
      t.date :start_date
      t.integer :duration
      t.string :passphrase
      t.timestamps null: false
    end
  end
end
