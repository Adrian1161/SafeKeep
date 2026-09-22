require "rails_helper"

RSpec.describe PasswordStore do

    before do 
        Passsword.create(
            account_id: "1",
            username: "CaseTest",
            password: "CaseTest",
            website: "Microsoft"
        )
    end

    it "Displays the user information that was saved" do 
        password_store = PasswordStore.new("1")
        puts "Users Information"
        password_store.viewPasswords
        expect { password_store.viewPasswords}.not_to raise_error
    end
end 