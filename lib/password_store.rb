class PasswordStore

    attr_accessor :username, :password, :website, :password_identifiers, :account_id

    # Method that allows user to add a password they want to save 
    def addPassword(username, password, website, password_identifiers)
        #TODO: Implement logic for adding a password
    end

    # Method that allows the user can remove password 
    def removePassword(password_identifiers)
        #TODO: Implement logic for removing password
    end

    # Method that allows the user to update saved passwords
    def updatePassword(password_identifiers)
        #TODO: Implement logic for updating password
    end

    # Method for setting timer to remind user to change their password
    def passwordTimer(password_identifiers)
        #TODO: Implement logic for adding a password timer 
    end
    


end