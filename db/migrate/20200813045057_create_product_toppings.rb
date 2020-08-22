class CreateProductToppings < ActiveRecord::Migration[6.0]
  def change
    create_table :product_toppings do |t|
      t.references :product, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
