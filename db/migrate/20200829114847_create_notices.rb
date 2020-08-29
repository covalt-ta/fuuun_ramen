class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.string :action, default: '', null: false
      t.boolean :checked, default: false
      t.references :admin, null: false, index: true, foreign_key: true
      t.references :reservation, index: true, foreign_key: true
      t.timestamps
    end
  end
end
