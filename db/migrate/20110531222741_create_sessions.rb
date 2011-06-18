class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
