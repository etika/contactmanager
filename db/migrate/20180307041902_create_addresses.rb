class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :lane
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.integer :contact_id

      t.timestamps null: false
    end
  end
end
