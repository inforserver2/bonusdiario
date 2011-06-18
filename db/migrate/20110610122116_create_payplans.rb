class CreatePayplans < ActiveRecord::Migration
  def change
    create_table :payplans do |t|
      t.string :name

      t.timestamps
    end
  end
end
