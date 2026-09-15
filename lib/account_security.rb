require_relative "password_store"
# add back when testing is done

require "bcrypt"

class AccountSecurity
    # Allows the user to login in
    def login(enteredUsername, enteredPassword)
            # TODO: Implement login logic
            account = Account.find_by(username: enteredUsername)

        if account
            # Compares the hashed password in the database with the password the user entered
            if BCrypt::Password.new(account.password) == enteredPassword
                account_id = account.account_id

                # Passes accountId to password_store.rb used to find users saved information
                passwordStore = PasswordStore.new(account_id)

                puts "Login successful welcome."
            else
                raise "Wrong password"
            end

        else
            raise "Account not found"
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
