# Carrie's Closet

## Getting Started
After a clean install of this repo, you'll need to run `bundle install` inside 
  the `CarriesCloset` root folder. This will install all needed requirements.

## Database Creation
You'll need to have MySQL installed and running locally.

## Database Initialization
Depending on whether or not you've run the Rails server recently, or if you're 
  having troubles with your database/server, you'll want to run the following:
```shell
bin/rails db:drop
bin/rails db:create && bin/rails db:migrate && bin/rails db:seed
```
## ActionMailer for Confirmation Emails
- You can preview a sample email at http://localhost:3000/rails/mailers/user_mailer/ by clicking on new email.
- Make sure you have copied the environment variables that contain the GMAIL account info from `example.env` into your `.env` file.
- When you hit the create request button,
    - you can see the html and text versions of the confirmation email in your terminal.
    - you should also receive the actual email from Carrie's Closet (carries.closet.confirmations@gmail.com) at the email address you entered on the form, so make sure you enter       a valid address.
- If you want to temporarily turn off emails from sending (you'll still be able to see them in you terminal):
    1. navigate to `config\environments\development.rb`
    2. search for the line `config.action_mailer.perform_deliveries = true`
    3. change it to `config.action_mailer.perform_deliveries = false`
    4. restart server
    
    Note: that same line is also in `config\environments\production.rb` and `config\environments\test.rb`, so you can also make that change in those files as well depending on   
    what environment you are working in.
    
    When you want to start receiving emails again, just make those lines `config.action_mailer.perform_deliveries = true` again and restart the server. 
    

## General Rails Tips
- Always use `bin/rails` when running commands from the terminal (this will 
  point to the proper Carrie's Closet project)
- `bin/rails console --sandbox` will create a sandboxed version of a REPL-style 
  console, loaded with all the classes and data from your running app. Any 
  changes made in the sandbox will be reverted when you `exit`.
- `bin/rails generate Tweet user:references body:text likes:integer` will 
  create a `Tweet` model that belongs to a `User` model. Each `Tweet` will be 
  stored in the database with a `body` text field and a `likes` counter.
- `bin/rails destroy Tweet` will revert all generated files for the previous
  `Tweet` model.
