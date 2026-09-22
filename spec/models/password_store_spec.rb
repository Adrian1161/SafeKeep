require "rails_helper"

RSpec.describe PasswordStore do

    before do 
        Password.create(
            username: "CaseTest",
            password: "CaseTest",
            website:"Microsoft",
            password_identifiers: 123,
            account_id: "1"
        )
    end

    it "Displays the user information that was saved" do 
        password_store = PasswordStore.new("1")
        puts "Users Information"
        password_store.viewPasswords
        expect { password_store.viewPasswords}.not_to raise_error
    end

    it "Allows the user to create a password" do
        password_store = PasswordStore.new("1")
        password_store.addPassword(
            "CaseTest",
            "CaseTest",
            "Amazon.com",
            111,
            1
        )
        expect(Password.count).to eq(2)
    end
end 