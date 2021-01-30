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
- For now, when you create a new request you can view the html and text versions of the confirmation email for that request in your terminal upon clicking on the create request button.

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
