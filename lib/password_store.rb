class PasswordStore

    attr_accessor :username, :password, :website, :password_identifiers, :account_id

    def initialize(account_id) 
        @account_id = account_id 
    end

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

    def viewPasswords()
        password = Password.where(account_id: @account_id)

        if password.empty?
        
        else
            password.each do |savedInformation|
                puts "Website: #{savedInformation.website}"
                puts "Username: #{savedInformation.username}"
                puts "Password: #{savedInformation.password}"
                puts "---------------------------"
            end
        end 
    end

    


end