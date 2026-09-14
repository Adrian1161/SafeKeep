require_relative "password_store"
require "bcrypt"
require "sqlite3"

class AccountSecurity
    # Allows the user to login in
    def login(enteredUsername, enteredPassword)
            # TODO: Implement login logic
            account = db.get_first_row("Select * FROM accounts WHERE username = ?",
            [ enteredUsername ])

        if account
            # Compares the hashed password in the database with the password the user entered
            if BCrypt::Password.new(account[1]) == enteredPassword
                accountId = account[0]

                # Passes accountId to password_store.rb used to find users saved information
                passwordStore = PasswordStore.new(accountId)

                puts "Login successful welcome."
            else
                puts "Wrong password"
            end

        else
            puts "Account not found"
        end
    end

    # The user can enter their recovery phrase in order to update their password
    def AccountRecovery(username, recoveryPhrase)
      # TODO: Implement account recovery using recovery phrase
    end

    # Creates and stores a recovery phrase for the user
    def recoveryPhraseCreation(username)
      # TODO: Implement logic for generating a recovery phrase
    end
end
