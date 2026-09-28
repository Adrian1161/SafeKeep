# frozen_string_literal: true

# this is for the login menu, where the user will either log in or create a new account
require "tty-prompt"
require_relative "../account_security"
require_relative "main_menu"

class LoginMenu
  def initialize
    @prompt = TTY::Prompt.new
    @account_security = AccountSecurity.new
  end

  #This is for the login menu to be able to be called
  def call
    action = @prompt.select("Welcome to SafeKeep. What would you like to do?", [
      { name: "Log in", value: :login },
      { name: "Create account", value: :create_account },
      { name: "Use recovery phrase", value: :recovery_phrase }
    ])

    case action
    when :login
      login
    when :create_account
      create_account
    when :recovery_phrase
      recover_account
    end
  end

  private

  # Method to handle user login
  def login
    username = @prompt.ask("Username:")
    password = @prompt.mask("Password:")
    account_passwords = @account_security.login(username, password)
    if account_passwords
      # TODO fix this once MainMenu has been done
      #MainMenu.new(account_passwords).call
      MainMenu.new(account_passwords).main_menu
    else
      call
    end
  end

  # Method to handle user account creation
  def create_account
    username = @prompt.ask("Choose a username:")
    password = @prompt.mask("Choose a password:")
    pin = @prompt.mask("Choose a PIN:")
    recovery_phrase = @account_security.recoveryPhraseCreation

    account = Account.new(
      account_id: SecureRandom.uuid,
      username: username,
      password: password,
      pin: pin,
      recovery_phrase: recovery_phrase
    )

    if account.save
      puts "Account created. Please log in."
      call
    else
      puts "Account could not be created:"
      account.errors.full_messages.each { |message| puts "- #{message}" }
      call
    end
  end

  # Method to handle user account recovery
  def recover_account
    username = @prompt.ask("Username:")
    phrase = @prompt.mask("Recovery phrase:")
    account = Account.find_by(username: username)

    unless account&.authenticate_recovery_phrase(phrase)
      puts "Could not find account or recovery phrase is wrong."
      return
    end

    new_password = @prompt.mask("New password:")

    if account.update(password: new_password)
      puts "Password changed"
      call
    else
      puts "Could not change password."
    end
  end
end
