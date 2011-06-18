class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :contract
      t.float :value
      t.integer :status, :default=>0
      t.string :description
      t.string :token

      t.timestamps
    end
    add_index :bills, :contract_id
  end
end
