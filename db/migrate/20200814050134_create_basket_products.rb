class CreateBasketProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :basket_products do |t|
      t.references :basket, index: true, null: false, foreign_key: true
      t.references :product, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
