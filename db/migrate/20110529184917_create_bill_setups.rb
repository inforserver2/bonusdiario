class CreateBillSetups < ActiveRecord::Migration
  def change
    create_table :bill_setups do |t|
      t.boolean :close
      t.boolean :money
      t.boolean :comm
      t.boolean :mail
      t.references :bill

      t.timestamps
    end
    add_index :bill_setups, :bill_id
  end
end
