
# frozen_string_literal: true

# This menu is once a user has selected a password to view; it will show the password and websites associated with it

class VaultMenu
require "tty-prompt"
require_relative "../password_store"

def initialize(account_id)
    @account_id = account_id
    @password_store = PasswordStore.new(@account_id)
    @prompt = TTY::Prompt.new
end

def vaultMenu
    choices = @prompt.select("Vault Menu") do |menu|
        menu.choice "Saved Websites"
        menu.choice "Add Password"
        menu.choice "Main Menu"
    end

    case choices 
        when "Saved Websites"
            # go to viewpasswords and return saved passwords loop them for the saved websites menu
            savedWebsites
        when "Add Password"
            username = @prompt.ask("username: ")
            password = @prompt.ask("Password: ")
            website = @prompt.ask("Website: ")
    
            @password_store.addPassword(
                username,
                password,
                website
            )
        when "Main Menu"
            return
        end
    end

    def savedWebsites
        choices = @password_store.viewWebsites
        chosenWebsite = @prompt.select("Websites", choices + ["Back"])
    case chosenWebsite
        when "Back"
            return
        else
            websiteSelection(chosenWebsite)
        end
    end


    def websiteSelection(chosenWebsite)
        choices = @prompt.select(chosenWebsite) do |menu|
            menu.choice "Remove Website Information"
            menu.choice "Show Website Information"
            menu.choice "Update Password"
            menu.choice "Set Timer"
            menu.choice "Remove Timer"
            menu.choice "Matching Credentials"
            menu.choice "Back"
        end 
        case choices
            when "Remove Website Information"
                @password_store.removePassword(chosenWebsite)
                return
            when "Show Website Information"
                @password_store.websiteInformation(chosenWebsite)
                return
            when "Update Password"
                newPassword = @prompt.ask("New password")
                @password_store.updatePassword(chosenWebsite, newPassword)
                return
            when "Set Timer"
                @password_store.passwordTimer(chosenWebsite)
                return
            when "Remove Timer"
                @password_store.removeTimer(chosenWebsite)
                return
            when "Matching Credentials"
                @password_store.combinationFinder(chosenWebsite)
                return
            when "Back"
                return

     #add return to each to take the user back
            end
    end
end