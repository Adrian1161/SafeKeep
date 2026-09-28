# frozen_string_literal: true

# This is the main menu which will be shown to the user after they have logged in and can select an option from the menu
require "tty-prompt"
require_relative "../password_store"
require_relative "vault_menu"
class MainMenu

def initialize(account_id)
    @account_id = account_id
    @prompt = TTY::Prompt.new
    @password_store = PasswordStore.new(account_id)
end
def main_menu
    loop do 
        choices = @prompt.select("Main Menu") do |menu|
            menu.choice "Vault"
            menu.choice "Logout"
        end

        case choices
        when "Vault"
            vault_menu = VaultMenu.new(@account_id)
            vault_menu.vaultMenu
        when "Logout"
            break
        end
    end
end

end