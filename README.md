# Carrie's Closet

## Getting Started
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
```

This will create the `cc_mysql` MySQL Docker container, the `cc_redis` Redis 
caching store, and the `cc_server` Rails server. Both commands should complete 
without error to let you know everything is running properly. The Rails server
will run on http://127.0.0.1:3000 in most environments.
