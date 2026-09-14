# Design

## Modules
- ### Account
  - #### Purpose of the Module
    - The Account module is meant to represent the users account as an object. it contains the required attributes such as `username`, `password`, `recovery phrase`, and `PIN`.
    - The password which the user creates immediately gets encrypted for security purposes.
    - The `PIN` is used as an additional security measure to ensure that when the user wants to see an unencrypted credential they can enter the PIN and their stored password will be decoded.
  - #### How it interacts within the application
    - Account will be created when a user creates their account so we can store their credentials
    - PIN will be used to see the unencrypted version of their password to ensure it is the user looking at it.
    - Also Account will be used during login.
- AccountSecurity
  - Purpose of the Module
  - How it interacts within the application
- ### PassHandler
  - #### Purpose of the Module
    - The PassHandler module is meant to represent some of the account actions which are supposed to take place. Such as encrypting the password for storage, decrypting the password to see in displayed properly, and the biggest portion is to generate passwords.
    - The password generator will have a set of arguments (still under review what all those arguments are), which those will translate to password requirements from the user perspective to generate a usable password for the user.
  - #### How it interacts within the application
    - So when the user adds a new password to store, PassHandler will encrypt it for security purposes.
    - The description will only take place if the user gives us their PIN which was set up in account so they can see the password in plain text.
    - The password generator will generate a plain text string based on a set of requirements which translate into arguments of the module method, and will generate a password based on those requirements.
- PasswordStore
  - Purpose of the Module
  - How it interacts within the application


## User Interface
- This is a terminal application