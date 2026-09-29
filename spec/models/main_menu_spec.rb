# frozen_string_literal: true

require "rails_helper"
require_relative "../../lib/cli/main_menu"

RSpec.describe MainMenu do
  let(:prompt) { double("prompt") }
  let(:password_store) { double("password store") }

  before do
    allow(TTY::Prompt).to receive(:new).and_return(prompt)
    allow(PasswordStore)
      .to receive(:new)
            .with("account-123")
            .and_return(password_store)
  end

  it "returns from the menu when the user logs out" do
    allow(prompt).to receive(:select).and_return("Logout")

    expect { described_class.new("account-123").main_menu }
      .not_to raise_error
  end

  it "opens the vault menu when the user selects Vault" do
    vault_menu = double("vault menu")

    allow(prompt).to receive(:select).and_return("Vault", "Logout")
    allow(VaultMenu)
      .to receive(:new)
            .with("account-123")
            .and_return(vault_menu)

    expect(vault_menu).to receive(:vaultMenu)

    described_class.new("account-123").main_menu
  end
end
