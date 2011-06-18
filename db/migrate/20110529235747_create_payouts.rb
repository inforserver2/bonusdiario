class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.references :user
      t.float :value
      t.integer :status, :default=>0

      t.timestamps
    end
  end
end
