class PasswordStore

    attr_accessor :username, :password, :website, :password_identifiers

    def initialize(account_id) 
        @account_id = account_id 
    end

    # Method that allows user to add a password they want to save 
    def addPassword(username, password, website, password_identifiers, account_id, change_password_reminder)
        Password.create(
            username: username,
            password: password,
            website: website,
            password_identifiers: password_identifiers,
            account_id: @account_id,
            change_password_reminder: @change_password_reminder
        )
    end

    # Method that allows the user can remove password 
    def removePassword(website)
        password = Password.find_by(
            website: website,
            account_id: @account_id
        )

        if password
            password.destroy
        
        else
             puts "Could not find a password for #{website}"
        end 
    end

    # Method that allows the user to update saved passwords
    def updatePassword(website, new_password)
        password = Password.find_by(
            website: website,
            account_id: @account_id
        )

        if password 
            password.update(password: new_password)
            puts "password for #{website} Updated to #{password.password}"
        else
             puts "Could not find website: #{website}"
        end 
    end

    # Method for setting timer to remind user to change their password
    def passwordTimer(website) 
        password = Password.find_by(
            website: website,
            account_id: @account_id
        )

        if password
            password.update(change_password_reminder: 1.month.from_now)
            puts "Password reminder set for #{password.change_password_reminder}"
        else
            puts "Could not find website: #{website}"
        end
    end

    def checkTimer()
        password = Password.where(
            account_id: @account_id
        )
        password.each do |password|
            if password.change_password_reminder && password.change_password_reminder <= Date.current
                puts "Password for #{password.website} needs to be updated"
            end
        end 
    end

    def viewPasswords()
        password = Password.where(account_id: @account_id)

        if password.exists?
             password.each do |savedInformation|
                puts "Website: #{savedInformation.website}"
                puts "Username: #{savedInformation.username}"
                puts "Password: #{savedInformation.password}"
                puts "---------------------------"
            end
        
        else
            puts "Could not find any saved passwords"
        end 
    end

    


end