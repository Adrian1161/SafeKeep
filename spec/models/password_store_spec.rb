require "rails_helper"

RSpec.describe PasswordStore do

    before do 
        Password.create(
            username: "CaseTest",
            password: "CaseTest",
            website:"Microsoft",
            password_identifiers: 123,
            account_id: "1",
            change_password_reminder: nil
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
            1,
            nil
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

    it "Allows the user to add a reminder to change their password" do 
        password_store = PasswordStore.new("1")
        expect{password_store.passwordTimer("Microsoft")}.not_to raise_error
    end

    it "tells the user when its time to change password" do
        password_store = PasswordStore.new("1")
        Password.create(
            username: "CaseTest2",
            password: "CaseTese2",
            website: "Amazon",
            password_identifiers: 12,
            account_id: "1",
            change_password_reminder: Date.current - 1
        )

        password_store = PasswordStore.new("1")

        expect{password_store.checkTimer}.to output("Password for Amazon needs to be updated\n").to_stdout

    end

    it "allows the user to remove their timer" do
        password_store = PasswordStore.new("1")
        password_store.passwordTimer("Microsoft")
        password_store.removeTimer("Microsoft")
        
        expect(password.change_password_reminder).to be_nil
    end


end 