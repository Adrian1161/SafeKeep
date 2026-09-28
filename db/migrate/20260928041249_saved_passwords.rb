class SavedPasswords < ActiveRecord::Migration[8.1]
  def change
    create_table :passwords do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :website, null: false
      t.string :password_identifiers
      t.string :account_id, null: false
      t.datetime :change_password_reminder
      t.timestamps
    end
  end
end