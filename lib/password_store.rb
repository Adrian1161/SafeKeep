require "tty-table"
class PasswordStore

    attr_accessor :username, :password, :website, :password_identifiers

    def initialize(account_id) 
        @account_id = account_id 
    end

    # Method that allows user to add a password they want to save 
    def addPassword(username, password, website)
        Password.create(
            username: username,
            password: password,
            website: website,
            password_identifiers: nil,
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

    #method for removing timer
    def removeTimer(website)
        password = Password.find_by(
            website: website,
            account_id: @account_id
        )

        if password
            password.update(change_password_reminder: nil)
            puts "Password reminder removed for #{website}"
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

    def viewWebsites()
        choices = []
        websites = Password.where(account_id: @account_id)

        if websites.empty?
            return "No saved Websites found"
        else
            websites.each do |website|
                choices << website.website
            end
            return choices         
    end
end

      def websiteInformation(website)
        websites = Password.find_by(account_id: @account_id, website: website)

        if websites 
            table = TTY::Table.new(
                header: ["Website", "Username", "Password"]
            )
                table << [websites.website, websites.username, websites.password]
        else
            puts "Could not find any saved passwords"
        end 
    end

    def combinationFinder(website)
        password = Password.find_by(
            website: website,
            account_id: @account_id
        )

        if password
            table = TTY::Table.new(
                header: ["Matching Websites"]
            )
        matches = Password.where(
            username: password.username,
            password: password.password,
            account_id: @account_id
        )
            if matches.exists?
                matches.each do |savedInformation|
                    if savedInformation.website != website
                    table << [savedInformation.website]
                    end
                end
            else
                puts "No matches found"
            end
        else
            puts "Websites not found"
        end

    end


end