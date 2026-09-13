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

class Account

  attr_accessor :username, :password, :recoveryPhrase, :pin

  def initialize(username, password, recoveryPhrase, pin)
    @username = username
    @password = encryptPassword(password)
    @recoveryPhrase = recoveryPhrase
    @pin = pin
  end

  def encryptPassword(password)
    #TODO: Implement encryption logic
  end

  def decryptPassword(password)
    #TODO: Implement decryption logic
  end

  def fetchAccountDetailsFromDatabase
    #TODO: Implement fetching account details from database
  end

  def updateAccountDetailsFromDatabase
    #TODO: Implement updating account details in database
  end

end