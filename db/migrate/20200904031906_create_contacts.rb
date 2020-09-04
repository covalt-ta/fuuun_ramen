class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name,  null: false
      t.text :text,    null: false
      t.string :email, null: false
      t.string :phone_number
      t.timestamps
    end
  end
end
