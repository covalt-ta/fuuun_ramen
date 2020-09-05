class CreateProductEats < ActiveRecord::Migration[6.0]
  def change
    create_table :product_eats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
    add_index :product_eats, [:user_id, :product_id], unique: true
  end
end
