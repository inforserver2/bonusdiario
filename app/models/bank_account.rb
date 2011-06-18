class BankAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank
  belongs_to :bank_account_type
  validates_presence_of :user_id
  validates_presence_of :bank_id, :bank_account_type, :on=>:update
  validates_presence_of :agency, :account, :cpf_owner, :fullname_owner, :extra, :on=>:update
end
