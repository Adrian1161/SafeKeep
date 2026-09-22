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

    it "Allows the user to delete a password entry" do
        password_store = PasswordStore.new("1")
        password_store.removePassword(
            "Microsoft"
        )
        expect(Password.count).to eq(0)
    end 

    it "A user tries to delete a password that does not exist" do 
        password_store = PasswordStore.new("1")
        expect{ password_store.removePassword("FailCase")}.to output("Could not find a password for FailCase\n").to_stdout
    end

    it "Allows the user to update password for a website" do 
        password_store = PasswordStore.new("1")
        expect{
            password_store.updatePassword(Microsoft, UpdatedPasswordTest).to output("password for Microsoft Updated to UpdatedPasswordTest\n").to_stdout

        }
    end
end 