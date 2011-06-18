class CreateCommTypes < ActiveRecord::Migration
  def change
    create_table :comm_types do |t|
      t.string :name
      t.float :porcentage
      t.references :payplan

      t.timestamps
    end
    add_index :comm_types, :payplan_id
  end
end
