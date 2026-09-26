# pass_handler.rb

=begin
This class handles password-related operations.
=end
require "securerandom"
class PassHandler

  def initialize
  end

  # This method generates a random password based on certain criteria (story 7).
  def generate_password(length: 16, lowercase: true, uppercase: true, digits: true, symbols: true)
    character_sets = []
    character_sets << ("a".."z").to_a if lowercase
    character_sets << ("A".."Z").to_a if uppercase
    character_sets << ("0".."9").to_a if digits
    character_sets << "!@#$%^&*()-_=+[]{}?".chars if symbols

    raise ArgumentError, "Select at least one character type" if character_sets.empty?
    raise ArgumentError, "Length must be at least #{character_sets.length}" unless length.is_a?(Integer) && length >= character_sets.length

    characters = character_sets.map do |set|
      set[SecureRandom.random_number(set.length)]
    end

    pool = character_sets.flatten
    (length - characters.length).times do
      characters << pool[SecureRandom.random_number(pool.length)]
    end

    (characters.length - 1).downto(1) do |index|
      other_index = SecureRandom.random_number(index + 1)
      characters[index], characters[other_index] =
        characters[other_index], characters[index]
    end

    characters.join
  end

  # This method decrypts a selected password, adding validation using a given PIN which is confirmed in the account (story 5).
  def decryptPassword(password, pin, account)
    if pin == account.pin
      password
    else
      nil
    end
  end

  #adding method to find shared login websites story 6
  def findCommonWebsiteCreds(selected_password, saved_passwords)
    saved_passwords.select do |saved|
      saved.id != selected_password.id &&
        saved.username == selected_password.username &&
        saved.password == selected_password.password
    end
      .map(&:website)
      .uniq
  end

end