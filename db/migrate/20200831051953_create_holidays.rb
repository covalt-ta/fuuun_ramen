class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.date :day, null: false
      t.references :shop, null: false, foreign_key: true
      t.timestamps
    end
  end
end
