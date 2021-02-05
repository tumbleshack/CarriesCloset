# Carrie's Closet

## Getting Started
On windows, make sure you set git [to use unix line endings](https://docs.github.com/en/github/using-git/configuring-git-to-handle-line-endings) 
when checking out and committing. 

If you've already checked out and have windows line endings, you may encounter
an error stating: `env: ruby\r: No such file or directory`. To resolve, run
`find ./ -type f -exec dos2unix {} \;`.

After a clean install of this repo, you'll need to run `bundle install` inside 
the `CarriesCloset` root folder. This will install all needed requirements.
  
Additionally, **duplicate** the file `example.env` in the root level directory. 
Once duplicated, rename the duplicate, e.g. `example.env (1)`, to just `.env`. 
This may cause the `.env` to disapear from your file brower, but don't worry 
if you've named the file correctly.

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
- Accessing Environment Variables Containing GMAIL Account info:
    - Make a copy of `config\EXAMPLE_local_env.yml` in the config file and rename it just `local_env.yml`. This way the SMTP settings will have access to the GMAIL login info. 
- When you hit the create request button,
    - you can see the html and text versions of the confirmation email in your terminal.
    - you should also receive the actual email from Carrie's Closet (carries.closet.confirmations@gmail.com) at the email address you entered on the form, so make sure you enter       a valid address.
- If you want to temporarily disable email deliveries (you'll still be able to see them in you terminal):
    1. navigate to `config\environments\development.rb`
    2. search for the line `config.action_mailer.perform_deliveries = true`
    3. change it to `config.action_mailer.perform_deliveries = false`
    4. restart server
    
    Note: that same line is also in `config\environments\production.rb` and `config\environments\test.rb`, so you can also make that change in those files as well depending on   
    what environment you are working in.
    
    Note: When you want to start receiving emails again, just make those lines `config.action_mailer.perform_deliveries = true` again and restart the server. 
    
- If you get an SMTP Authentication Error, it usually means the environment variable with the GMAIL account info is not working, so follow these steps:
    1. Go to `config\development.rb` and scroll down to the ActionMailer settings where you will see `user_name: ENV["GMAIL_USERNAME"],` and `password: ENV["APP_PASSWORD"]`
    2. Go to `config\EXAMPLE_local_env.yml` and copy the `GMAIL_USERNAME` value and paste it in place of `ENV["GMAIL_USERNAME"]` (leave the comma at the end of the line). 
    3. Copy the `APP_PASSWORD` value and paste it in place of `ENV["APP_PASSWORD"]`.
    4. Save and restart server.
    
    Note: that these same lines are also in `config\environments\production.rb` and `config\environments\test.rb`, so you can also make that change in those files as well      
    depending on what environment you are working in.

    

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
  
## Running with Docker
To run the full app stack, run the following commands:
```shell
docker-compose build --parallel && docker-compose up -d
docker exec cc_server sh -c "bin/rails db:create && bin/rails db:migrate && bin/rails db:seed"
docker exec cc_server sh -c "rails webpacker:install"
```

Note that on Windows, you may need to run these command seprately. Eg.
```
docker-compose build --parallel
docker-compose up -d
docker exec cc_server sh -c "bin/rails db:create"
docker exec cc_server sh -c "bin/rails db:migrate"
docker exec cc_server sh -c "bin/rails db:seed"
docker exec cc_server sh -c "rails webpacker:install"
```

This will create the `cc_mysql` MySQL Docker container, the `cc_redis` Redis 
caching store, and the `cc_server` Rails server. Both commands should complete 
without error to let you know everything is running properly. The Rails server
will run on http://127.0.0.1:3000 in most environments.

