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

  it "Allows the user to change their password using recovery phrase" do 
    account_security = AccountSecurity.new
    account = Account.create(
      account_id: "2",
      username: "TestCase",
      password: "TestPassword",
      pin: 123,
      recovery_phrase: "Dog Cat Car"
    )
    
    allow(account_security).to receive(:gets).and_return("NewTestPass")
    account_security.accountRecovery("TestCase", "Dog Cat Car")
    puts account.reload.password
    expect(account.reload.password).to eq("NewTestPass")

  end
end
