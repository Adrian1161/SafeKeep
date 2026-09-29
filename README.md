# README

# SafeKeep


### Short Description
SafeKeep is a terminal application designed to store user credentials securely.
Users can create an account and save their credentials and see which websites share the same credential.
Safekeep can also generate new passwords for the user based upon requirements given by the user.

### Installation/setup instructions
1. Clone the repository and download it on your machine
2. Run the `safe_keep.py` in installation mode to ensure all dependencies are installed and DB connectivity is working
   1. execute `ruby safe_keep.rb --install`
3. Setup is then complete. Run `ruby bin/safe_keep.rb` to start SafeKeep.

### Instructions for running the app
1. Run `ruby bin/safe_keep.rb` to start SafeKeep.
2. User will be prompted to create an account, log in, or to recover the account.
3. Once a user logs in, they can choose which vault to enter which will allow the following
   1. View all credentials stored in the vault
   2. Add a new credential to the vault
   3. Edit an existing credential in the vault
   4. Delete an existing credential in the vault
4. The user can also set timers for specific credentials as a reminder when it needs to be updated.
5. Once the user is done reviewing their passwords, they can log out.
### Instructions for running the tests and generating the coverage report
- For this section simply execute the following command: `bundle exec rspec`
- We added the gem `simplecov` to generate the coverage report.
- The report should be generated in the `coverage` directory.
  - In this path -> `coverage/index.html`
  - You can view this in your browser.
  - Also coverage percentage will be displayed along with the rspec results.
  - Sample -> `Line coverage: 205 / 252 (81.34%)`
### List of main features
- Users can create an account
- Users can log in and see stored passwords
- Users can select to view a credential, which will initially be encrypted
    - Users will be able to decrypt the credential using a PIN.
### Any known limitations
- Is not integrated with any phone application
- DB is local, not cloud-based
- It does not integrate with browsers
### Names of all team members
- Adrian Estrada
- Philip Savov