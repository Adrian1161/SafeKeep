# account_schema.rb DB table creation

ActiveRecord::Schema[8.1].define(version: 1) do
  create_table "accounts" do |a|
    a.string "account_id", null: false
    a.string "username", null: false
    a.string "password", null: false
    a.integer "pin", null: false
    a.string "recovery_phrase", null: false
    a.timestamps
    a.index ["account_id"], unique: true
    a.index ["username"], unique: true
  end
end