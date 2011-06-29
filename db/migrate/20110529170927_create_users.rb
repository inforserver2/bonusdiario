class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :nick
      t.string :name
      t.string :password
      t.string :email1
      t.string :email2
      t.integer :status, :default=>0
      t.integer :sponsor_id
      t.integer :visit,:default=>0
      t.string :redir_from
      t.string :token
      t.string :phone
      t.string :mobile
      t.string :msn
      t.string :skype
      t.string :gtalk
      t.string :cpf
      t.string :rg
      t.date :birth
      t.string :avatar
      t.boolean :admin
      t.references :gender, :default=>0
      t.references :address
      t.references :bank_account
      t.integer :sponsored_count, :default=>0

      t.timestamps
    end
    add_index :users, :token
    add_index :users, :name
    add_index :users, :sponsor_id
    add_index :users, :address_id
    add_index :users, :bank_account_id
  end
end
