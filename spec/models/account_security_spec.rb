require "rails_helper"
require_relative "../../lib/account_security"


RSpec.describe AccountSecurity do
  before do
    recovery_phrase = BipMnemonic.to_mnemonic(
      bits: 128,
      language: "english"
    )

    Account.create(
    account_id: "1",
    username: "CaseTest",
    password: BCrypt::Password.create("CaseTest"),
    pin: 123,
    recovery_phrase: recovery_phrase
    )
end

  it "Log in is successful" do
    account_security = AccountSecurity.new

    #run1 = account_security.login("CaseTest","CaseTest")

    puts Account.all.inspect

    expect {account_security.login("CaseTest", "CaseTest")}.not_to raise_error

end 
  it "User Enters wrong password" do
    account_security = AccountSecurity.new

    expect {account_security.login("CaseTest", "WrongPassword")}.to raise_error
  end

  it "Creates a recovery phrase for the user" do
    account_security = AccountSecurity.new
    recovery_phrase = account_security.recoveryPhraseCreation

    expect(recovery_phrase).not_to be_nil 

  end
end
