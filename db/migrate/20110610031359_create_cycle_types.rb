class CreateCycleTypes < ActiveRecord::Migration
  def change
    create_table :cycle_types do |t|
      t.string :name
      t.float :value

      t.timestamps
    end
  end
end
