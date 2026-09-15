ActiveRecord::Schema[8.1].define(version: 1) do
    create_table "passwords" do |p|
        p.string "username", null: false
        p.string "password", null: false
        p.string "website", null: false
        p.string "password_identifiers"
        p.string "account_id", null: false
        p.timestamps


        p.index["password_id"], unique: true
    end
end