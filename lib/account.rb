# account.rb
=begin
Pairing Log

Session 1 — 2026-09-12

Driver: Philip
Navigator: Adrian

Work Completed
- Defining Account class
- Adding attr_accessor for username, password, recoveryPhrase, and pin
- Adding TODO comments for encryption, decryption, fetching account details, and updating account details
=end

=begin
This file contains the Account class, which represents a user account with attributes such as username, password, recovery phrase, and PIN.
The class includes methods for encrypting and decrypting passwords, fetching account details from a database, and updating account details in the database.
TODO comments have been added to indicate areas that need implementation.
=end
class Account
  # Attributes needed for account
  attr_accessor :username, :password, :recoveryPhrase, :pin

  # Method for creating Account
  def initialize(username, password, recoveryPhrase, pin)
    @username = username
    @password = encryptPassword(password)
    @recoveryPhrase = recoveryPhrase
    @pin = pin
  end

  # Method for encrypting password
  def encryptPassword(password)
    # TODO: Implement encryption logic
  end

  # Method for encrypting password
  def decryptPassword(password)
    # TODO: Implement decryption logic
  end

  # Method for fetching account details from the database
  def fetchAccountDetailsFromDatabase
    # TODO: Implement fetching account details from database
  end

  # Method for updating account details in the database
  def updateAccountDetailsFromDatabase
    # TODO: Implement updating account details in database
  end

end