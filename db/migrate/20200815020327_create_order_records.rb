class CreateOrderRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :order_records do |t|
      t.references :user, index: true, unique: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
