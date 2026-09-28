# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.

ActiveRecord::Schema[8.1].define(version: 1) do
  create_table "accounts", force: :cascade do |t|
    t.string "account_id", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "pin", null: false
    t.string "recovery_phrase_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_accounts_on_account_id", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end
end
