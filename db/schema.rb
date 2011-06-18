# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110610122116) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.string   "name"
    t.string   "number"
    t.string   "neighborhood"
    t.string   "extra"
    t.string   "zip"
    t.string   "state_name"
    t.string   "city_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["country_id"], :name => "index_addresses_on_country_id"
  add_index "addresses", ["user_id"], :name => "index_addresses_on_user_id"

  create_table "bank_account_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bank_id"
    t.integer  "bank_account_type_id"
    t.string   "agency"
    t.string   "account"
    t.string   "cpf_owner"
    t.string   "fullname_owner"
    t.string   "extra"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bank_accounts", ["bank_account_type_id"], :name => "index_bank_accounts_on_bank_account_type_id"
  add_index "bank_accounts", ["bank_id"], :name => "index_bank_accounts_on_bank_id"
  add_index "bank_accounts", ["user_id"], :name => "index_bank_accounts_on_user_id"

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bill_setups", :force => true do |t|
    t.boolean  "close"
    t.boolean  "money"
    t.boolean  "comm"
    t.boolean  "mail"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bill_setups", ["bill_id"], :name => "index_bill_setups_on_bill_id"

  create_table "bills", :force => true do |t|
    t.integer  "contract_id"
    t.float    "value"
    t.integer  "status",      :default => 0
    t.string   "description"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["contract_id"], :name => "index_bills_on_contract_id"

  create_table "comm_types", :force => true do |t|
    t.string   "name"
    t.float    "porcentage"
    t.integer  "payplan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comm_types", ["payplan_id"], :name => "index_comm_types_on_payplan_id"

  create_table "comms", :force => true do |t|
    t.integer  "bill_id"
    t.float    "value"
    t.integer  "status",       :default => 0
    t.integer  "comm_type_id"
    t.integer  "user_id"
    t.integer  "payout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comms", ["bill_id"], :name => "index_comms_on_bill_id"
  add_index "comms", ["comm_type_id"], :name => "index_comms_on_comm_type_id"
  add_index "comms", ["payout_id"], :name => "index_comms_on_payout_id"
  add_index "comms", ["user_id"], :name => "index_comms_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.string   "sponsor_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts", ["service_id"], :name => "index_contracts_on_service_id"
  add_index "contracts", ["user_id"], :name => "index_contracts_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cycle_types", :force => true do |t|
    t.string   "name"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cycles", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "sponsor_id"
    t.integer  "cycle_type_id"
    t.integer  "status",          :default => 0
    t.integer  "sponsored_count", :default => 0
    t.integer  "from_cycle_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cycles", ["contract_id"], :name => "index_cycles_on_contract_id"
  add_index "cycles", ["cycle_type_id"], :name => "index_cycles_on_cycle_type_id"
  add_index "cycles", ["from_cycle_id"], :name => "index_cycles_on_from_cycle_id"
  add_index "cycles", ["sponsor_id"], :name => "index_cycles_on_sponsor_id"
  add_index "cycles", ["token"], :name => "index_cycles_on_token"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "genders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payouts", :force => true do |t|
    t.integer  "user_id"
    t.float    "value"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payplans", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", :force => true do |t|
    t.string   "subject"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "fullname"
    t.string   "nick"
    t.string   "name"
    t.string   "password"
    t.string   "email1"
    t.string   "email2"
    t.integer  "status",          :default => 0
    t.integer  "sponsor_id"
    t.integer  "visit",           :default => 0
    t.string   "redir_from"
    t.string   "token"
    t.string   "phone"
    t.string   "mobile"
    t.string   "msn"
    t.string   "skype"
    t.string   "gtalk"
    t.string   "cpf"
    t.string   "rg"
    t.date     "birth"
    t.string   "avatar"
    t.integer  "gender_id",       :default => 0
    t.integer  "address_id"
    t.integer  "bank_account_id"
    t.integer  "sponsored_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["address_id"], :name => "index_users_on_address_id"
  add_index "users", ["bank_account_id"], :name => "index_users_on_bank_account_id"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["sponsor_id"], :name => "index_users_on_sponsor_id"
  add_index "users", ["token"], :name => "index_users_on_token"

end
