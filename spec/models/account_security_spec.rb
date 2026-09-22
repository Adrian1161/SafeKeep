require "rails_helper"
require_relative "../../lib/account_security"


RSpec.describe AccountSecurity do
  before do 
    Account.create(
    account_id: "1",
    username: "CaseTest",
    password: BCrypt::Password.create("CaseTest"),
    pin: 123,
    recovery_phrase: "Testing Phrase"
    )
end

  it "Log in is successful" do
    account_security = AccountSecurity.new

    run1 = account_security.login("CaseTest","CaseTest")

    puts Account.all.inspect

    expect {account_security.login("CaseTest", "CaseTest")}.not_to raise_error

end 
  it "User Enters wrong password" do
    account_security = AccountSecurity.new

    expect {account_security.login("CaseTest", "WrongPassword")}.to raise_error
  end
end
