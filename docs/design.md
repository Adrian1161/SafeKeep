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
- ### AccountSecurity
  - #### Purpose of the Module
    - The AccountSecurity module will allow users to sign in to their account. It will also give users a way to recover their account using a recovery phrase.
    - AccountSecurity is also responsible for creating a recovery phrase.
  - #### How it interacts within the application
    - AccountSecurity takes in `username` and `password` which is then checked against the database if correct it will sign in the user.
    - AccountRecovery takes in `username` and a `recoveryPhrase` which will let the user change their password.
    - AccountPhraseCreation makes a phrase which is then attached to the users entry in the database for use in AccountRecovery
- ### PassHandler
  - #### Purpose of the Module
    - The PassHandler module is meant to represent some of the account actions which are supposed to take place. Such as encrypting the password for storage, decrypting the password to see in displayed properly, and the biggest portion is to generate passwords.
    - The password generator will have a set of arguments (still under review what all those arguments are), which those will translate to password requirements from the user perspective to generate a usable password for the user.
  - #### How it interacts within the application
    - So when the user adds a new password to store, PassHandler will encrypt it for security purposes.
    - The description will only take place if the user gives us their PIN which was set up in account so they can see the password in plain text.
    - The password generator will generate a plain text string based on a set of requirements which translate into arguments of the module method, and will generate a password based on those requirements.
- ### PasswordStore
  - #### Purpose of the Module
    - The passwordStore module is responsible for storing the `username`, `password`, `website`, and `passwordIdentifiers` that the user enters. It will will also allow the user to remove and update their passwords.
    - Users can also set a timer to remind them to when to change their passwords.
  - #### How it interacts within the application
    - When the user wants to save a new password they will fill out all the details which is then saved and stored.
    - They will then be able to remove passwords or update them.
    - passwords can also have timers set on them that remind the user to update their password.


## User Interface
- This is a terminal application which will be using a formatted interface to display information to the user.
- We decided to go with TTY Gems as it allows for a more user-friendly interface within the terminal.
- We have three main UI parts:
  - #### Login Menu
    - This is the first menu that the user will interact with when they start the application.
    - Login Menu
  ```
  Welcome to SafeKeep. What would you like to do?
  
  >   Log in
    Create account
    Use recovery phrase
    ```
    - Create Account
    ```
    Choose a username: philipsa
    Choose a password: ••••••••
    Choose a PIN: ••••
  
    Your recovery phrase is:
    cabbage marble thumb switch virus reward naive note bulk admit price nominee
    ```
    - Use Recovery Phrase
    ```
    Username: philipsa
    Recovery phrase: ••••••••••••
  
    New password: ••••••••
    ```
    - #### Main Menu
      - This allows the user to go to their vault or log out
  ```
  Main Menu
  
  > Vault
    Logout
  ```
    - #### Vault Menu
      - This allows the user to view and manage their passwords.
      - Vault Menu
  ```
  Vault Menu
  
  > Saved Websites
    Add Password
    Main Menu
  ```
  - Add a Password
  ```
  username: philipsa
  Password: ••••••••
  Website: example.com
  ```
  - Saved Websites
  ```
  Websites
  
  > example.com
  another-site.com
  Back
  ```
  - Website Actions
  ```
  example.com
  
  > Remove Website Information
    Show Website Information
    Update Password
    Set Timer
    Remove Timer
    Matching Credentials
    Back
  ```
## Design Decisions
- For the UI we decided to use the TTY Gems because of the simplicity it allowed us to show our sensitive data in a nice formatted way to the user.
- As well as, it allows for easy navigation and interaction within the application for the user, especially for a terminal application.
- Also, we used rails for the ease of development and integration with local storage, and set up of databases and tables.
- Rails allowed for use to be able to complete this project in a timely manner.