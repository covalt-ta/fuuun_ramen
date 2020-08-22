class CreateProductToppingRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :product_topping_relations do |t|
      t.references :product_topping, null: false, index: true, foreign_key: true
      t.references :topping, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
