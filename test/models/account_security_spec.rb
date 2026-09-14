require "rspec"
require_relative "../../lib/account_security"
require "sqlite3"

RSpec.describe AccountSecurity do
    it "logs in with valid credentials" do
        account_security = AccountSecurity.new
        db = SQLite3::Database.new(":memory:")
    end
end
