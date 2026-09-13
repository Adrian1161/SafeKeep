# account.rb

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

  # Adding Getters and Setters
  def username
    @username
  end
  def password
    @password
  end
  def recoveryPhrase
    @recoveryPhrase
  end
  def pin
    @pin
  end

  def recoveryPhrase=(new_recoveryPhrase)
    @recoveryPhrase = new_recoveryPhrase
  end

  def pin=(new_pin)
    @pin = new_pin
  end

  def password=(new_password)
    @password = new_password
  end

  def username=(new_username)
    @username = new_username
  end

end