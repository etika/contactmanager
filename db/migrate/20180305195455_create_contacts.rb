class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :user_id
      t.string :phone_number, array: true, default: []
      t.timestamps null: false
    end
  end
end
