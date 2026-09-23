require_relative "password_store"
# add back when testing is done

require "bcrypt"
require "bip_mnemonic2"

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
                 # this will check which password needs to be updated if the user choose to set a reminder
                passwordStore.checkTimer
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
    def recoveryPhraseCreation()
        # This line creates the phrases for the user default values are 128 bits and in english
        recovery_phrase = BipMnemonic.to_mnemonic(
            bits: 128,
            language: "english"
        )

        puts "Your recovery phrases are: #{recovery_phrase}"

        return recovery_phrase

    end
end
