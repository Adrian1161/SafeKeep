# frozen_string_literal: true

require "rails_helper"
require_relative "../../lib/cli/vault_menu"

RSpec.describe VaultMenu do
  let(:prompt) { double("prompt") }
  let(:password_store) { double("password store") }

  before do
    allow(TTY::Prompt).to receive(:new).and_return(prompt)
    allow(PasswordStore)
      .to receive(:new)
            .with("account-123")
            .and_return(password_store)
  end

  it "checks password timers and returns to the main menu" do
    stub_selections("Main Menu")
    expect(password_store).to receive(:checkTimer)

    described_class.new("account-123").vaultMenu
  end

  it "adds a password and returns to the vault menu" do
    stub_selections("Add Password", "Main Menu")
    allow(prompt).to receive(:ask).with("username: ").and_return("alice")
    allow(prompt).to receive(:ask).with("Password: ").and_return("secret")
    allow(prompt).to receive(:ask).with("Website: ").and_return("GitHub")

    expect(password_store)
      .to receive(:addPassword)
            .with("alice", "secret", "GitHub")

    expect(password_store).to receive(:checkTimer).twice

    described_class.new("account-123").vaultMenu
  end

  it "shows password timers and returns to the vault menu" do
    stub_selections("Check Password Timers", "Main Menu")

    expect(password_store).to receive(:checkTimer).twice
    expect(password_store).to receive(:viewTimer)

    described_class.new("account-123").vaultMenu
  end

  it "shows saved websites and lets the user go back" do
    stub_selections("Saved Websites", "Back")
    allow(password_store).to receive(:viewWebsites).and_return(["GitHub"])

    expect(password_store).to receive(:checkTimer)
    expect(password_store).to receive(:viewWebsites)

    described_class.new("account-123").vaultMenu
  end

  it "returns from the selected website menu when the user goes back" do
    stub_selections("Saved Websites", "GitHub", "Back")
    allow(password_store).to receive(:viewWebsites).and_return(["GitHub"])

    expect(password_store).to receive(:checkTimer)
    expect(password_store).to receive(:viewWebsites)

    described_class.new("account-123").vaultMenu
  end

  def stub_selections(*selections)
    allow(prompt).to receive(:select) do |_message, *_options, &configure_menu|
      if configure_menu
        menu = double("menu")
        allow(menu).to receive(:choice)
        configure_menu.call(menu)
      end

      selections.shift
    end
  end
end