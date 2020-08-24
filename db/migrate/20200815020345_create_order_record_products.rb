class CreateOrderRecordProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_record_products do |t|
      t.references :order_record, index: true, null: false, foreign_key: true
      t.references :product_topping, index: true, null: false, foreign_key: true
      t.references :reservation, index:true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
