# frozen_string_literal: true

require 'rspec'
require_relative "../../lib/pass_handler"

RSpec.describe PassHandler do
  subject(:handler) { described_class.new }

  describe "#generate_password" do
    it "returns the requested length" do
      expect(handler.generate_password(length: 20)).to have_attributes(length: 20)
    end

    it "includes at least one character from each enabled type by default" do
      password = handler.generate_password

      expect(password).to match(/[a-z]/)
      expect(password).to match(/[A-Z]/)
      expect(password).to match(/[0-9]/)
      expect(password.chars & "!@#$%^&*()-_=+[]{}?".chars).not_to be_empty
    end

    it "uses only the enabled character types" do
      password = handler.generate_password(
        length: 12,
        lowercase: true,
        uppercase: false,
        digits: true,
        symbols: false
      )

      expect(password).to match(/\A[a-z0-9]+\z/)
      expect(password).to match(/[a-z]/)
      expect(password).to match(/[0-9]/)
    end

    it "raises an error if no character types are enabled" do
      expect do
        handler.generate_password(
          lowercase: false,
          uppercase: false,
          digits: false,
          symbols: false
        )
      end.to raise_error(ArgumentError, "Select at least one character type")
    end

    it "raises an error if the length is shorter than the enabled character types" do
      expect do
        handler.generate_password(length: 3)
      end.to raise_error(ArgumentError)
    end
  end

  describe "#decryptPassword" do
    let(:account) { double("account", pin: "1234") }

    it "returns the password when the PIN matches" do
      expect(handler.decryptPassword("saved-password", "1234", account))
        .to eq("saved-password")
    end

    it "returns nil when the PIN does not match" do
      expect(handler.decryptPassword("saved-password", "0000", account))
        .to be_nil
    end
  end

  describe "#findCommonWebsiteCreds" do
    let(:password_record) do
      Struct.new(:id, :username, :password, :website)
    end

    let(:selected_password) do
      password_record.new(1, "alex", "shared-secret", "first.test")
    end

    it "returns other websites with the same username and password" do
      saved_passwords = [
        selected_password,
        password_record.new(2, "alex", "shared-secret", "second.test"),
        password_record.new(3, "alex", "different-secret", "third.test"),
        password_record.new(4, "someone-else", "shared-secret", "fourth.test")
      ]

      expect(handler.findCommonWebsiteCreds(selected_password, saved_passwords))
        .to eq(["second.test"])
    end

    it "does not return duplicate website names" do
      saved_passwords = [
        selected_password,
        password_record.new(2, "alex", "shared-secret", "second.test"),
        password_record.new(3, "alex", "shared-secret", "second.test")
      ]

      expect(handler.findCommonWebsiteCreds(selected_password, saved_passwords))
        .to eq(["second.test"])
    end

    it "returns an empty array when there are no other matches" do
      expect(handler.findCommonWebsiteCreds(selected_password, [selected_password]))
        .to eq([])
    end
  end
end