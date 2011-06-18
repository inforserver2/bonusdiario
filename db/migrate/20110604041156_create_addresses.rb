class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user
      t.references :country
      t.string :name
      t.string :number
      t.string :neighborhood
      t.string :extra
      t.string :zip
      t.string :state_name
      t.string :city_name

      t.timestamps
    end
    add_index :addresses, :user_id
    add_index :addresses, :country_id
  end
end
