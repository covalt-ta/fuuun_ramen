class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name,                null: false
      t.string :email,               null: false
      t.integer :open_time_zone_id,  null: false
      t.integer :close_time_zone_id, null: false
      t.integer :holiday_id
      t.string :postal_code,         null: false
      t.integer :prefecture_id,      null: false
      t.string :city,                null: false
      t.string :block,               null: false
      t.string :building
      t.string :phone_number,        null: false
      t.references :admin,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
