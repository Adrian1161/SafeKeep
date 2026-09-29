# frozen_string_literal: true

require "rails_helper"
require_relative "../../lib/cli/login_menu"

RSpec.describe LoginMenu do
  let(:prompt) { double("prompt") }
  let(:account_security) { double("account security") }

  before do
    allow(TTY::Prompt).to receive(:new).and_return(prompt)
    allow(AccountSecurity).to receive(:new).and_return(account_security)
  end

  it "logs in and opens the main menu after a successful login" do
    main_menu = double("main menu")

    allow(prompt).to receive(:select).and_return(:login)
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Password:").and_return("secret")

    allow(account_security)
      .to receive(:login)
            .with("alice", "secret")
            .and_return("account-123")

    allow(MainMenu)
      .to receive(:new)
            .with("account-123")
            .and_return(main_menu)

    expect(main_menu).to receive(:main_menu)

    described_class.new.call
  end

  it "retries the menu after a failed login" do
    invalid_account = double("account")
    allow(invalid_account)
      .to receive(:authenticate_recovery_phrase)
            .with("wrong phrase")
            .and_return(false)

    allow(prompt).to receive(:select).and_return(:login, :recovery_phrase)
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Password:").and_return("bad-password")
    allow(prompt).to receive(:mask).with("Recovery phrase:").and_return("wrong phrase")
    allow(account_security)
      .to receive(:login)
            .with("alice", "bad-password")
            .and_return(nil)
    allow(Account).to receive(:find_by).with(username: "alice").and_return(invalid_account)

    expect { described_class.new.call }
      .to output("Could not find account or recovery phrase is wrong.\n").to_stdout
  end

  it "creates an account successfully and returns to the menu" do
    account = double("account", save: true)
    main_menu = double("main menu")

    allow(prompt).to receive(:select).and_return(:create_account, :login)
    allow(prompt).to receive(:ask).with("Choose a username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Choose a password:").and_return("secret")
    allow(prompt).to receive(:mask).with("Choose a PIN:").and_return("1234")
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Password:").and_return("secret")
    allow(account_security).to receive(:recoveryPhraseCreation).and_return("recovery phrase")
    allow(account_security).to receive(:login).with("alice", "secret").and_return("account-123")
    allow(Account).to receive(:new).and_return(account)
    allow(MainMenu).to receive(:new).with("account-123").and_return(main_menu)
    expect(main_menu).to receive(:main_menu)

    expect { described_class.new.call }
      .to output("Account created. Please log in.\n").to_stdout
  end

  it "shows account validation errors when account creation fails" do
    errors = double("errors", full_messages: ["username is invalid"])
    account = double("account", save: false, errors: errors)
    main_menu = double("main menu")

    allow(prompt).to receive(:select).and_return(:create_account, :login)
    allow(prompt).to receive(:ask).with("Choose a username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Choose a password:").and_return("secret")
    allow(prompt).to receive(:mask).with("Choose a PIN:").and_return("1234")
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Password:").and_return("secret")
    allow(account_security).to receive(:recoveryPhraseCreation).and_return("recovery phrase")
    allow(account_security).to receive(:login).with("alice", "secret").and_return("account-123")
    allow(Account).to receive(:new).and_return(account)
    allow(MainMenu).to receive(:new).with("account-123").and_return(main_menu)
    allow(main_menu).to receive(:main_menu)

    expect { described_class.new.call }
      .to output(
            "Account could not be created:\n- username is invalid\n"
          ).to_stdout
  end

  it "changes the password after successful recovery" do
    account = double("account")
    main_menu = double("main menu")

    allow(prompt).to receive(:select).and_return(:recovery_phrase, :login)
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Recovery phrase:").and_return("recovery phrase")
    allow(prompt).to receive(:mask).with("New password:").and_return("new-secret")
    allow(prompt).to receive(:mask).with("Password:").and_return("new-secret")
    allow(account).to receive(:authenticate_recovery_phrase)
                        .with("recovery phrase").and_return(true)
    allow(account).to receive(:update).with(password: "new-secret").and_return(true)
    allow(Account).to receive(:find_by).with(username: "alice").and_return(account)
    allow(account_security).to receive(:login).with("alice", "new-secret").and_return("account-123")
    allow(MainMenu).to receive(:new).with("account-123").and_return(main_menu)
    allow(main_menu).to receive(:main_menu)

    expect { described_class.new.call }
      .to output("Password changed\n").to_stdout
  end

  it "reports when the recovered password cannot be changed" do
    account = double("account")

    allow(prompt).to receive(:select).and_return(:recovery_phrase)
    allow(prompt).to receive(:ask).with("Username:").and_return("alice")
    allow(prompt).to receive(:mask).with("Recovery phrase:").and_return("recovery phrase")
    allow(prompt).to receive(:mask).with("New password:").and_return("new-secret")
    allow(account).to receive(:authenticate_recovery_phrase)
                        .with("recovery phrase").and_return(true)
    allow(account).to receive(:update).with(password: "new-secret").and_return(false)
    allow(Account).to receive(:find_by).with(username: "alice").and_return(account)

    expect { described_class.new.call }
      .to output("Could not change password.\n").to_stdout
  end
end