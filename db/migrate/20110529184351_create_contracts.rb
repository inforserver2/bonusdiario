class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :service
      t.references :user
      t.integer :status, :default=>0

      t.timestamps
    end
    add_index :contracts, :service_id
    add_index :contracts, :user_id
  end
end
