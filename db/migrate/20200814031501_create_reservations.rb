class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.date :day, index: true
      t.integer :time_zone_id, index: true
      t.integer :count_person_id, index: true
      t.timestamps
    end
  end
end
