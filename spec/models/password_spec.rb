# frozen_string_literal: true

require "rails_helper"

RSpec.describe Password do
  it "saves and retrieves a password" do
    password = described_class.create!(
      username: "alice",
      password: "secret",
      website: "GitHub",
      account_id: "account-123"
    )

    saved_password = described_class.find(password.id)

    expect(saved_password.website).to eq("GitHub")
  end
end
