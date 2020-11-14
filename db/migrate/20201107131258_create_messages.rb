class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true
      t.text :message, null: false
      t.timestamps
    end
  end
end
