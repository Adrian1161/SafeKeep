# account.rb
require 'bcrypt'
=begin
Since we are using rails, and defined the table structure in account_schema.rb, the getters and setters are handled by rails.
So we only need to define the validations and associations.
TODO comments have been added to indicate areas that need implementation.
=end
class Account < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
end
