class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.references :contract
      t.integer :sponsor_id
      t.references :cycle_type
      t.integer :status, :default=>0
      t.integer :sponsored_count, :default=>0
      t.integer :from_cycle_id
      t.string :token
      t.timestamps
    end
    add_index :cycles, :contract_id
    add_index :cycles, :sponsor_id
    add_index :cycles, :cycle_type_id
    add_index :cycles, :from_cycle_id
    add_index :cycles, :token
  end
end
