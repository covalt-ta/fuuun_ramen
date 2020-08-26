class CreateInformation < ActiveRecord::Migration[6.0]
  def change
    create_table :information do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :admin, null: false, foreign_key: true
      t.timestamps
    end
  end
end
