class CreateComms < ActiveRecord::Migration
  def change
    create_table :comms do |t|
      t.references :bill
      t.float :value
      t.integer :status, :default=>0
      t.references :comm_type
      t.references :user
      t.references :payout
      t.timestamps
    end
    add_index :comms, :bill_id
    add_index :comms, :user_id
    add_index :comms, :comm_type_id
    add_index :comms, :payout_id
  end
end
