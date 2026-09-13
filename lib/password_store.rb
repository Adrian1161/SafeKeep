class PasswordStore

    attr_accessor :username, :password, :website, :passwordIdentifiers

    # Method that allows user to add a password they want to save 
    def addPassword(username, password, website, passwordIdentifiers)
    end

    # Method that allows the user can remove password 
    def removePassword(passwordIdentifiers)
    end

    # Method that allows the user to update saved passwords
    def updatePassword(passwordIdentifiers)
    end

    # Method for setting timer to remind user to change their password
    def passwordTimer(passwordIdentifiers)
    end


    # Getters
    def passwordIdentifiers
        @passwordIdentifiers
    end

    def username
        @username
    end

    def password
        @password
    end

    def website
        @website
    end

    # Setters 
    def passwordIdentifiers=(new_passwordIdentifiers)
        @passwordIdentifiers = new_passwordIdentifiers
    end

    def username=(new_username)
        @username = new_username
    end
    
    def password=(new_password)
        @password = new_password
    end

    def website=(new_website)
        @website = new_website
    end


    


end